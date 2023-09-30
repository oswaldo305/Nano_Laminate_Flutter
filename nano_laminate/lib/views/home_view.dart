import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nano_laminate/blocs/archive/archive_bloc.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';
import 'package:nano_laminate/widgets/alerts/alert_add_archive_widget.dart';
import 'package:nano_laminate/widgets/archive/archive_button_widget.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final authService = AuthFirebaseService();
  late ArchiveBloc archiveBloc;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    archiveBloc = BlocProvider.of<ArchiveBloc>(context);
    archiveBloc.getArchives();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
      
      debugPrint(index.toString());
    });
  }

@override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
         actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(context: context, builder: (_) => const AlertAddArchiveWidget());

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
      body: Container(
        margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: buildModulesGrid(size),
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

Center textPrincipalContent() {
  return const Center(
      child: Text(
        'Animate a crear nuevos archivos.',
        style: TextStyle(fontSize: 18),
      ),
    );
}

  BlocBuilder<ArchiveBloc, ArchiveState> buildModulesGrid(size) {

    return BlocBuilder<ArchiveBloc, ArchiveState>(
      builder: (context, state){

        List<Archive> archives = state.archives;
        List<ArchiveButtonWidget> listArchiveButton = [];

        if(archives.isEmpty){
          return textPrincipalContent();
        }

        for(var archive in archives){
          ArchiveButtonWidget archiveButton = ArchiveButtonWidget(archive: archive);
          listArchiveButton.add(archiveButton);
        }

        return buildGrid(size, listArchiveButton);

      }
    );

  }

  AlignedGridView buildGrid(Size size, List<ArchiveButtonWidget> listArchiveButton) {

    return AlignedGridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
      itemCount: listArchiveButton.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: listArchiveButton[index],
        );
      },
    );
    
  }

}