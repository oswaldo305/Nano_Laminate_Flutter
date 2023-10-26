import 'package:flutter/material.dart';
import 'package:nano_laminate/views/base_page_view.dart';

void showAlertLogoutStatus(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Sesión finalizada correctamente.",
                style: TextStyle(color: Colors.black),
              ),
              // Image.asset(
              //   "assets/imgIllustration/carro_vacio.jpg",
              //   height: 250.0,
              // ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                MyNotification().dispatch(context);
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        );
      });
}
