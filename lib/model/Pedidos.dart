import 'package:server/server.dart';
import 'package:server/model/Clientes.dart';
import 'package:server/model/DetallePedido.dart';
import 'package:server/model/Empleados.dart';

class Pedidos extends ManagedObject<Pedido> implements Pedido{}

class Pedido{
  @primaryKey
  int id_pedido;
  
  @Column(indexed: true)
  DateTime fecha_pedido;
  
  @Column(indexed: true)
  DateTime fecha_envio;
  
  @Relate(#pedido)
  Clientes id_cliente;

  @Relate(#empleado)
  Empleados empleado;

  ManagedSet<DetallePedido> detalle;
}