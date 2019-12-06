import 'package:aqueduct/managed_auth.dart';
import 'package:server/model/Usuarios.dart';
import 'controller/AreasClienteController.dart';
import 'controller/AreasController.dart';
import 'controller/ClientesController.dart';
import 'controller/DetallePedidoController.dart';
import 'controller/EmpleadosController.dart';
import 'controller/PedidosController.dart';
import 'controller/ProductosAreasClienteController.dart';
import 'controller/ProductosController.dart';
import 'controller/UsuariosController.dart';
import 'server.dart';

class ServerChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;
  
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistenStore = PostgreSQLPersistentStore.fromConnectionInfo("dart", "1", "127.0.0.1", 5432, "tienda_dart");
    
    context = ManagedContext(dataModel,persistenStore);

    final authStorage = ManagedAuthDelegate<Usuarios>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/auth/token').link(() => AuthController(authServer));
    router.route("/productos[/:idproducto]").link( () => ProductosController(context) ); 
    router.route("/pedidos[/:idpedido]").link( () => PedidosController(context) ); 
    router.route("/clientes[/:idcliente]").link( () => ClientesController(context) ); 
    router.route("/areas[/:idarea]").link( () => AreasController(context) );
    router.route("/areascliente[/:idareacliente]").link( () => AreasClienteController(context) );
    router.route("/productosareascliente[/:idprodareacliente]").link( () => ProductosAreasClienteController(context) );
    router.route("/detallepedido[/:iddetped]").link( () => DetallePedidoController(context) );
    router.route("/empleados[/:idempleado]").link( () => EmpleadosController(context) );
    //router.route("/usuarios").link( () => UsuariosController(context,authServer) );
    router.route("/usuarios[/:user/:pwd]").link( () => UsuariosController(context,authServer) );
    
    return router;
  }
}