import 'package:server/server.dart';
import 'package:server/model/AreasCliente.dart';

class AreasClienteController extends ResourceController{
  AreasClienteController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllAreasCliente() async {
    final areasclienteQuery = Query<AreasCliente>(context);
    final areascliente = await areasclienteQuery.fetch();
    return Response.ok(areascliente);
  }

  @Operation.get('idareascliente')
  Future<Response> getAreaClienteByID(@Bind.path('idareascliente') int id) async{
    final areaclienteQuery = Query<AreasCliente>(context)..where((a)=>a.id_area_cliente).equalTo(id);
    final areacliente = await areaclienteQuery.fetch();
    if(areacliente == null){
      return Response.notFound();
    }
    return Response.ok(areacliente);
  }

  @Operation.post()
  Future<Response> insAreaCliente() async{
    final areacliente = AreasCliente()..read(await request.body.decode(), ignore: ["idAreaCliente"] );
    final query = Query<AreasCliente>(context)..values = areacliente;
    final insertedAreaCliente = await query.insert();
    return Response.ok(insertedAreaCliente);
  }

  @Operation.put('idareacliente')
  Future<Response> updAreaCliente(@Bind.path('idareacliente') int id) async{
    final areacliente = AreasCliente()..read(await request.body.decode());
    final query = Query<AreasCliente>(context)..where((a) => a.id_area_cliente).equalTo(id)..values = areacliente;
    final updatedAreaCliente = await query.updateOne();
    return Response.ok(updatedAreaCliente);
  }

  @Operation.delete('idareacliente')
  Future<Response> delAreaCliente(@Bind.path('idareacliente') int id) async{
    final query = Query<AreasCliente>(context)..where((a)=>a.id_area_cliente).equalTo(id);
    final deletedAreaCliente = await query.delete();
    return Response.ok(deletedAreaCliente);
  }

}