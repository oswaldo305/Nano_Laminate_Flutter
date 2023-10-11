import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _startScan();
  }


  Future<void> _startScan() async {
    flutterBlue.scanResults.listen((results) {
      // Actualiza la lista de dispositivos Bluetooth encontrados.
      setState(() {
        devicesList = results.map((result) => result.device).toList();
      });
    });

    // Comienza a escanear dispositivos Bluetooth cercanos.
    await flutterBlue.startScan(
      timeout: const Duration(seconds: 10), // Puedes ajustar el tiempo de escaneo.
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterBlue.stopScan(); // Detiene el escaneo al salir de la pantalla.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: const Text('Bluetooth Scanner'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: devicesList.length,
          itemBuilder: (context, index) {
            final device = devicesList[index];
            debugPrint("device: ${device.name}");
            return ListTile(
              title: Text(device.name),
              subtitle: Text(device.id.toString()),
              onTap: () {
                // Aquí implementar una acción al seleccionar un dispositivo.
                device.connect();
              },
            );
          },
        ),
      ),
    );
  }
}