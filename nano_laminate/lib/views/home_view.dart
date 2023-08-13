import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
      
      print(index);
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
         actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Acción al presionar el icono "+"
              Navigator.pushReplacementNamed(context, 'bluetoothList');

            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Contenido principal de la pantalla',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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