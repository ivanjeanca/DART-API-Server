import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:server/server.dart';
import 'package:server/model/Usuarios.dart';

class UsuariosController extends ResourceController{
  UsuariosController(this.context, this.authServer);
  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAllUsuarios() async {
    final usuariosQuery = Query<Usuarios>(context)
      ..join(object: (u) => u.empleado);
    final usuarios = await usuariosQuery.fetch();
    return Response.ok(usuarios);
  }

  @Operation.post()
  Future<Response> createUser(@Bind.body() Usuarios user) async {
    if (user.username == null || user.password == null) 
      return Response.badRequest(body: {'error': 'Usuario y contraseña requeridos.'});

    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }

  @Operation.get('user','pwd')
  Future<Response> loginUser(@Bind.path('user') String usuario, @Bind.path('pwd') String pwd ) async {
    /*
      para agregar el clientID, por que si no, no jala el login
      aqueduct auth add-client --id com.patm.tienda --connect postgres://dart:1@localhost:5432/tienda_dart
    */
    const clientID = "com.patm.tienda";
    final body = "username=$usuario&password=$pwd&grant_type=password";
    final clientCredentials = Base64Encoder().convert("$clientID:".codeUnits);
    final response = await http.post(
      "http://localhost:8888/auth/token",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic $clientCredentials"
      },
      body: body
    );
    print(json.decode(response.body)['access_token']);
    return (response.statusCode == 200) ? Response.ok(response.body) : Response.notFound();
  }
}