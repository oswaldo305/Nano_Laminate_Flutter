import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/archive/archive_bloc.dart';
import 'package:nano_laminate/firebase_options.dart';
import 'package:nano_laminate/routes/route.dart' as route;
import 'package:nano_laminate/services/notifications_service.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      BlocProvider(create: (context) => ArchiveBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nano Laminate',
      onGenerateRoute: route.controller,
      initialRoute: route.checkAuthView,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

