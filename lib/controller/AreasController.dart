import 'package:server/server.dart';
import 'package:server/model/Areas.dart';

class AreasController extends ResourceController{
  AreasController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllAreas() async {
    final areasQuery = Query<Areas>(context);
    final areas = await areasQuery.fetch();
    return Response.ok(areas);
  }

  @Operation.get('idarea')
  Future<Response> getAreaByID(@Bind.path('idarea') int id) async {
    final areaQuery = Query<Areas>(context)..where((a)=>a.id_area).equalTo(id);
    final area = await areaQuery.fetch();
    /*
    if(area == null){
      return Response.notFound();
    }
    return Response.ok(area);*/

    return (area == null) ? Response.notFound() : Response.ok(area);
  }

  @Operation.post()
  Future<Response> insArea() async {
    final area = Areas()..read(await request.body.decode(), ignore: ["idArea"] );
    final query = Query<Areas>(context)..values = area;
    final insertedArea = await query.insert();
    return Response.ok(insertedArea);
  }

  @Operation.put('idarea')
  Future<Response> updArea(@Bind.path('idarea') int id) async {
    final area = Areas()..read(await request.body.decode());
    final query = Query<Areas>(context)..where((a) => a.id_area).equalTo(id)..values = area;
    final updatedArea = await query.updateOne();
    return Response.ok(updatedArea);
  }

  @Operation.delete('idarea')
  Future<Response> delArea(@Bind.path('idarea') int id) async {
    final query = Query<Areas>(context)..where((a)=>a.id_area).equalTo(id);
    final deletedArea = await query.delete();
    return Response.ok(deletedArea);
  }
}