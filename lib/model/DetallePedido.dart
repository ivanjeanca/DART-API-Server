import 'package:server/server.dart';
import 'package:server/model/Pedidos.dart';
import 'package:server/model/Productos.dart';

class DetallePedido extends ManagedObject<Detalle_Pedido> implements Detalle_Pedido{}

class Detalle_Pedido{
  @primaryKey
  int id_detalle;

  @Relate(#detalle)
  Productos producto;

  @Relate(#detalle)
  Pedidos pedido;

  double precio;
  double descuento;
  double cantidad;
}