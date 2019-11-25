import 'package:server/server.dart';
import 'package:server/model/Productos.dart';

class ProductosController extends ResourceController{

  ProductosController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllProductos() async {
    final productosQuery = Query<Productos>(context);
    final productos = await productosQuery.fetch();
    return Response.ok(productos);
  }

   @Operation.get('idproducto')
  Future<Response> getProductoByID(@Bind.path('idproducto') int id) async{

    final productoQuery = Query<Productos>(context)..where((a)=>a.id_producto).equalTo(id);
    final producto = await productoQuery.fetch();

    if( producto == null ){
      return Response.notFound();
    }

    return Response.ok(producto);
  }

  @Operation.post()
  Future<Response> insProducto() async{
    final producto = Productos()..read(await request.body.decode(), ignore: ["idProducto"] );
    final query = Query<Productos>(context)..values = producto;
    final insertedProducto = await query.insert();
    return Response.ok(insertedProducto);
  }

  @Operation.put('idproducto')
  Future<Response> updProducto(@Bind.path('idproducto') int id) async{
    final producto = Productos()..read(await request.body.decode());
    final query = Query<Productos>(context)..where((a) => a.id_producto).equalTo(id)..values = producto;
    final updatedProducto = await query.updateOne();
    return Response.ok(updatedProducto);
  }

  @Operation.delete('idproducto')
  Future<Response> delProducto(@Bind.path('idproducto') int id) async{
    final query = Query<Productos>(context)..where((a)=>a.id_producto).equalTo(id);
    final deletedProducto = await query.delete();
    return Response.ok(deletedProducto);
  }

}