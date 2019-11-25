import 'package:server/server.dart';

Future main() async {
  final app = Application<ServerChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Aplicacion iniciada en el puerto: ${app.options.port}.");
  print("Use Ctrl-C para detener la aplicación.");
}