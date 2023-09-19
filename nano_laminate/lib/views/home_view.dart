import 'package:flutter/material.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final authService = AuthFirebaseService();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
      
      debugPrint(index.toString());
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
         actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Acción al presionar el icono "+"
              Navigator.pushNamed(context, 'bluetoothList');

            },
          ),
          IconButton(
            onPressed: (){
              authService.logOut();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.login_outlined)
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Contenido principal de la pantalla',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Premium',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Conexiones',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}