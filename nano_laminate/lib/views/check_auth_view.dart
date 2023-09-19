import 'package:flutter/material.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';
import 'package:nano_laminate/views/home_view.dart';
import 'package:nano_laminate/views/login_view.dart';

class CheckAuthView extends StatelessWidget {
  const CheckAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = AuthFirebaseService();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if( !snapshot.hasData ){
              return const Text('espere');
            }

            if( snapshot.data == '' ){
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,  __, ___) => const LoginView(),
                    transitionDuration: const Duration(seconds: 0)
                  )
                );
              });
            }else{
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,  __, ___) => const HomeView(),
                    transitionDuration: const Duration(seconds: 0)
                  )
                );
              });
            }

            return Container();

          },
        ),
      ),
    );
  }
}