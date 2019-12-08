import 'package:server/server.dart';
import 'package:server/model/ProductoAreasCliente.dart';

class ProductosAreasClienteController extends ResourceController{
  ProductosAreasClienteController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllProductosAreasCliente() async {
    final q = Query<ProductoAreasCliente>(context)
      ..join(object: (pac) => pac.areascliente)
        .join(object: (ac) => ac.cliente).returningProperties((c) => [c.nombre])
      ..join(object: (pac) => pac.producto)
        .returningProperties((p) => [p.producto]);
    return Response.ok(await q.fetch());
  }

  @Operation.get('idprodareacliente')
  Future<Response> getAllProductosAreasClienteByID(@Bind.path('idprodareacliente') int id) async{
    final q = Query<ProductoAreasCliente>(context)
      ..join(object: (pac) => pac.areascliente)
        .join(object: (ac) => ac.cliente).returningProperties((c) => [c.nombre])
      ..join(object: (pac) => pac.producto)
        .returningProperties((p) => [p.producto])
      ..where((a)=>a.id_producto_area_cliente).equalTo(id);

    final areacliente = await q.fetch();
    return (areacliente != null) ? Response.ok(areacliente): Response.notFound();
  }

  @Operation.post()
  Future<Response> insAreaCliente() async{
    final productoareacliente = ProductoAreasCliente()..read(await request.body.decode(), ignore: ["idprodareacliente"] );
    final query = Query<ProductoAreasCliente>(context)..values = productoareacliente;
    final insertedProductoAreaCliente = await query.insert();
    return Response.ok(insertedProductoAreaCliente);
  }

  @Operation.put('idprodareacliente')
  Future<Response> updAreaCliente(@Bind.path('idprodareacliente') int id) async{
    final productoareacliente = ProductoAreasCliente()..read(await request.body.decode());
    final query = Query<ProductoAreasCliente>(context)..where((a) => a.id_producto_area_cliente).equalTo(id)..values = productoareacliente;
    final updatedProductoAreaCliente = await query.updateOne();
    return Response.ok(updatedProductoAreaCliente);
  }

  @Operation.delete('idprodareacliente')
  Future<Response> delAreaCliente(@Bind.path('idprodareacliente') int id) async{
    final query = Query<ProductoAreasCliente>(context)..where((a)=>a.id_producto_area_cliente).equalTo(id);
    final deletedProductoAreaCliente = await query.delete();
    return Response.ok(deletedProductoAreaCliente);
  }
}