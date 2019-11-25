import 'package:server/server.dart';
import 'package:server/model/Empleados.dart';

class EmpleadosController extends ResourceController{
  EmpleadosController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllEmpleados() async {
    final empleadosQuery = Query<Empleados>(context);
    final empleados = await empleadosQuery.fetch();
    return Response.ok(empleados);
  }

   @Operation.get('idempleado')
  Future<Response> getEmpleadoByID(@Bind.path('idempleado') int id) async{
    final empleadoQuery = Query<Empleados>(context)..where((a)=>a.id_empleado).equalTo(id);
    final empleado = await empleadoQuery.fetch();
    return (empleado == null) ? Response.notFound() : Response.ok(empleado);
  }

  @Operation.post()
  Future<Response> insEmpleado() async{
    final empleado = Empleados()..read(await request.body.decode(), ignore: ["idEmpleado"] );
    final query = Query<Empleados>(context)..values = empleado;
    final insertedEmpleado = await query.insert();
    return Response.ok(insertedEmpleado);
  }

  @Operation.put('idempleado')
  Future<Response> updEmpleado(@Bind.path('idempleado') int id) async{
    final empleado = Empleados()..read(await request.body.decode());
    final query = Query<Empleados>(context)..where((a) => a.id_empleado).equalTo(id)..values = empleado;
    final updatedEmpleado = await query.updateOne();
    return Response.ok(updatedEmpleado);
  }

  @Operation.delete('id_empleado')
  Future<Response> delEmpleado(@Bind.path('id_empleado') int id) async{
    final query = Query<Empleados>(context)..where((a)=>a.id_empleado).equalTo(id);
    final deletedEmpleado = await query.delete();
    return Response.ok(deletedEmpleado);
  }
}