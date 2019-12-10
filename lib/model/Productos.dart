import 'package:server/server.dart';
import 'package:server/model/DetallePedido.dart';
import 'package:server/model/ProductoAreasCliente.dart';

class Productos extends ManagedObject<Producto> implements Producto{}

class Producto{
  @primaryKey
  int id_producto;

  @Column(unique: true)
  String producto;

  double costo;
  double precio;
  int existencia;
  int reorden;
  int comprometidas;
  bool vigente;
  String imagen;

  //ManagedSet<DetallePedido> detalle;
  DetallePedido detalle;
  //ManagedSet<ProductoAreasCliente> prodareacte;
  ProductoAreasCliente prodareacte;
}