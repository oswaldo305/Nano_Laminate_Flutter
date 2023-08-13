import 'package:flutter/material.dart';
import 'package:nano_laminate/views/bluetooth_list_view.dart';
import 'package:nano_laminate/views/home_view.dart';
import 'package:nano_laminate/views/login_view.dart';
import 'package:nano_laminate/views/register_view.dart';

const String loginView = 'login';
const String registerView = 'register';
const String homeView='home';
const String bluetoothListView='bluetoothList';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginView:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case registerView:
      return MaterialPageRoute(builder: (context) => const RegisterView());
    case homeView:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case bluetoothListView:
      return MaterialPageRoute(builder: (context) => const BluetoothListView());
    default:
      throw ('This page doesnt exist');
  }
}