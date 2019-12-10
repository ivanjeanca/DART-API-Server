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

  @Operation.get('user')
  Future<Response> getUsuarioByUser(@Bind.path('user') String usuarion) async {
    final usuariosQuery = Query<Usuarios>(context)
      ..join(object: (u) => u.empleado)
      ..where((u)=>u.username).equalTo(usuarion);
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
}