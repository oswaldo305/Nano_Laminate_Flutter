import 'package:flutter/material.dart';
import 'package:nano_laminate/routes/route.dart' as route;
import 'package:nano_laminate/services/notifications_service.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nano Laminate',
      onGenerateRoute: route.controller,
      initialRoute: route.loginView,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

