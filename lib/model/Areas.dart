import 'package:server/server.dart';
import 'package:server/model/AreasCliente.dart';

class Areas extends ManagedObject<Area> implements Area{}

class Area{
  @primaryKey
  int id_area;

  @Column(unique: true)
  String area;

  //ManagedSet<AreasCliente> areacte;
  AreasCliente areacte;
}