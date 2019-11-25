import 'package:server/server.dart';
import 'package:server/model/Pedidos.dart';
import 'package:server/model/Usuarios.dart';

class Empleados extends ManagedObject<Empleado> implements Empleado{}

class Empleado {
	@primaryKey
	int id_empleado;
	
	String nombre;
	String apaterno;
	String amaterno;

	@Column(indexed: true)
	DateTime fecha_nacimiento;
	
	@Column(unique: true)
	String correo;

	ManagedSet<Pedidos> empleado;
	Usuarios users;
}