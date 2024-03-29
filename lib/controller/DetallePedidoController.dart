import 'package:server/server.dart';
import 'package:server/model/DetallePedido.dart';

class DetallePedidoController extends ResourceController{

  DetallePedidoController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllDetallePedido() async {
    final detpedidosQuery = Query<DetallePedido>(context)
      ..join(object: (prod) => prod.producto)
      ..join(object: (pedi) => pedi.pedido)
        .join(object: (empl) => empl.empleado);
    
    final detpedidos = await detpedidosQuery.fetch();
    return Response.ok(detpedidos);
  }

  @Operation.get('iddetped')
  Future<Response> getDetallePedidoByID(@Bind.path('iddetped') int id) async {
    final detpedidosQuery = Query<DetallePedido>(context)
      ..join(object: (prod) => prod.producto)
      ..join(object: (pedi) => pedi.pedido)
        .join(object: (empl) => empl.empleado)
      ..where((d) => d.pedido.id_pedido).equalTo(id);
    
    final detpedidos = await detpedidosQuery.fetch();
    return Response.ok(detpedidos);
  }

  @Operation.post()
  Future<Response> insDetPedido() async{
    final detpedido = DetallePedido()..read(await request.body.decode(), ignore: ["idDetalle"] );
    final query = Query<DetallePedido>(context)..values = detpedido;
    final insertedDetPedido = await query.insert();
    return Response.ok(insertedDetPedido);
  }




}