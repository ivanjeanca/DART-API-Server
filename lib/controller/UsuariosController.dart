import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:server/server.dart';
import 'package:server/model/Usuarios.dart';

class UsuariosController extends ResourceController{
  UsuariosController(this.context, this.authServer);
  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() Usuarios user) async {
    if (user.username == null || user.password == null) {
      return Response.badRequest(body: {'error': 'Usuario y contraseña requeridos.'});
    }

    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }

  @Operation.get('user','pwd')
  Future<Response> loginUser(@Bind.path('user') String usuario, @Bind.path('pwd') String pwd ) async {
    final clientID = "com.patm.epp";
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
    print(body);
    return Response.ok(response.body);
  }
}