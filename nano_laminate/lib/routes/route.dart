import 'package:flutter/material.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/views/archive/archive_view.dart';
import 'package:nano_laminate/views/archive/file_upload_view.dart';
import 'package:nano_laminate/views/bluetooth_list_view.dart';
import 'package:nano_laminate/views/check_auth_view.dart';
import 'package:nano_laminate/views/home_view.dart';
import 'package:nano_laminate/views/login_view.dart';
import 'package:nano_laminate/views/register_view.dart';
import 'package:nano_laminate/widgets/archive/image_full_screen_widget.dart';

const String loginView = 'login';
const String registerView = 'register';
const String homeView='home';
const String bluetoothListView='bluetoothList';
const String checkAuthView= 'CheckAuthView';
const String archiveView = 'archive_view';
const String fileUploadView = 'file_upload_view';
const String imageFullScreen = 'image_full_screen_widget';

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
    case checkAuthView:
      return MaterialPageRoute(builder: (context) => const CheckAuthView());
    case archiveView:
      Archive archive = settings.arguments as Archive;
      return MaterialPageRoute(builder: (context) => ArchiveView(archive: archive));
    case fileUploadView:
      Archive archive = settings.arguments as Archive;
      return MaterialPageRoute(builder: (context) => FileUploadView(archive: archive));
    case imageFullScreen:
      String url = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => ImageFullScreen(imageURL: url));
    default:
      throw ('This page doesnt exist');
  }
}