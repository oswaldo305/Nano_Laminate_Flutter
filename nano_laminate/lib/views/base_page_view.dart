import 'package:flutter/material.dart';
import 'package:nano_laminate/widgets/tab_navigator_widget.dart';

class MyNotification extends Notification {}

class BasePageView extends StatefulWidget {
  const BasePageView({super.key});

  @override
  State<BasePageView> createState() => _BasePageViewState();
}

class _BasePageViewState extends State<BasePageView> {

  String keySeleccionada = 'home';
  String _currentPage = "home";
  List<String> pageKeys = ["home", "bluetoothList", "configuration_user_view"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "home":  GlobalKey<NavigatorState>(),
    "bluetoothList": GlobalKey<NavigatorState>(),
    "configuration_user_view": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      print(index);
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<MyNotification>(
      onNotification: (val) {
        return true;
      },
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (_currentPage != "home") {
              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _buildOffstageNavigator(keySeleccionada),
              // if(points!=null && points.isNotEmpty && (clientAddress.length ==0 || clientAddress.length == 1)) MessagePointsWidget(points: points),
            ],
          ),
          bottomNavigationBar: _bottomNavigation(context),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    debugPrint("tab item $tabItem");
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  Widget _bottomNavigation(BuildContext context) {
    // final textStyle =
    //     TextStyle(fontFamily: getFontFamilyTheme(), letterSpacing: 0.5);
    return BottomNavigationBar(
      // selectedItemColor: Colors.white,
      selectedItemColor: const Color.fromRGBO(150, 0, 19, 1),
      onTap: (int index) {
        _selectTab(pageKeys[index], index);
        setState(() {
          keySeleccionada = pageKeys[index];
        });
        debugPrint("keysss ${pageKeys[index]}");
        debugPrint("selected index: $_selectedIndex");
      },
      elevation: 20.0,
      // currentIndex: _selectedPage,
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Plantillas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Conexiones',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
    );
  }
}