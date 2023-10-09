import 'package:flutter/material.dart';
import 'package:nano_laminate/views/bluetooth_list_view.dart';
import 'package:nano_laminate/views/configuration/configuration_user_view.dart';
import 'package:nano_laminate/views/home_view.dart';
class TabNavigator extends StatelessWidget {

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator({super.key, required this.navigatorKey, required this.tabItem});

  @override
  Widget build(BuildContext context) {

    late Widget child;
    if(tabItem == "home"){
      child = const HomeView();
    }
    else if(tabItem == "bluetoothList"){

      child = const BluetoothScreen();
    }
    else if(tabItem == "configuration_user_view"){
      child = const ConfigurationUserView();
    }
    
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}