import 'package:server/server.dart';
import 'package:server/model/AreasCliente.dart';
import 'package:server/model/Pedidos.dart';

class Clientes extends ManagedObject<Cliente> implements Cliente{}

class Cliente{
  @primaryKey
  int id_cliente;

  String nombre;
  String direccion;
  
  @Column(unique: true)
  String correo;
  
  @Column(unique: true)
  String telefono;

  ManagedSet<Pedidos> pedido;
  ManagedSet<AreasCliente> areacte;
}