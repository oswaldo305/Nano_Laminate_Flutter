import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/archive/archive_bloc.dart';
import 'package:nano_laminate/routes/route.dart' as route;
import 'package:nano_laminate/services/notifications_service.dart';
import 'package:nano_laminate/theme.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Nano Laminate',
      onGenerateRoute: route.controller,
      initialRoute: route.checkAuthView,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

