import 'package:server/server.dart';
import 'package:server/model/Areas.dart';
import 'package:server/model/Clientes.dart';
import 'package:server/model/ProductoAreasCliente.dart';

class AreasCliente extends ManagedObject<Area_Cliente> implements Area_Cliente{}

class Area_Cliente{
  @primaryKey
  int id_area_cliente;
  int numero_empleados; 

  @Relate(#areacte)
  Areas area;

  @Relate(#areacte)
  Clientes cliente;

  ManagedSet<ProductoAreasCliente> prodareacte;
}