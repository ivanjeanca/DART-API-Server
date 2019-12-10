import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:server/server.dart';

class LoginController extends ResourceController{
  LoginController(this.context, this.authServer);
  final ManagedContext context;
  final AuthServer authServer;

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