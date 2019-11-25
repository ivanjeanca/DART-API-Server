import 'package:server/server.dart';
import 'package:server/model/AreasCliente.dart';
import 'package:server/model/Productos.dart';

class ProductoAreasCliente extends ManagedObject<producto_area_cliente> implements producto_area_cliente{}

class producto_area_cliente{
  @primaryKey
  int id_producto_area_cliente;
  
  int consumo;

  @Relate(#prodareacte)
  AreasCliente areascliente;

  @Relate(#prodareacte)
  Productos producto;
}