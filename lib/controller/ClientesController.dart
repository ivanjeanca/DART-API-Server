import 'package:server/server.dart';
import 'package:server/model/Clientes.dart';

class ClientesController extends ResourceController{

  ClientesController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllClientes() async {
    final clientesQuery = Query<Clientes>(context);
    final clientes = await clientesQuery.fetch();
    return Response.ok(clientes);
  }

   @Operation.get('idcliente')
  Future<Response> getClienteByID(@Bind.path('idcliente') int id) async{

    final clienteQuery = Query<Clientes>(context)..where((a)=>a.id_cliente).equalTo(id);
    final cliente = await clienteQuery.fetch();

    if( cliente == null ){
      return Response.notFound();
    }

    return Response.ok(cliente);
  }

  @Operation.post()
  Future<Response> insCliente() async{
    final cliente = Clientes()..read(await request.body.decode(), ignore: ["idCliente"] );
    final query = Query<Clientes>(context)..values = cliente;
    final insertedCliente = await query.insert();
    return Response.ok(insertedCliente);
  }

  @Operation.put('idcliente')
  Future<Response> updCliente(@Bind.path('idcliente') int id) async{
    final cliente = Clientes()..read(await request.body.decode());
    final query = Query<Clientes>(context)..where((a) => a.id_cliente).equalTo(id)..values = cliente;
    final updatedCliente = await query.updateOne();
    return Response.ok(updatedCliente);
  }

  @Operation.delete('idcliente')
  Future<Response> delCliente(@Bind.path('idcliente') int id) async{
    final query = Query<Clientes>(context)..where((a)=>a.id_cliente).equalTo(id);
    final deletedCliente = await query.delete();
    return Response.ok(deletedCliente);
  }

}