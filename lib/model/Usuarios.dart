import 'package:aqueduct/managed_auth.dart';
import 'package:server/server.dart';
import 'package:server/model/Empleados.dart';

class Usuarios extends ManagedObject<Usuario> implements Usuario, ManagedAuthResourceOwner<Usuario>{
  @Serialize(input: true, output: false)
  String password;
}

class Usuario extends ResourceOwnerTableDefinition{
  @Relate(#users)
  Empleados empleado;
}