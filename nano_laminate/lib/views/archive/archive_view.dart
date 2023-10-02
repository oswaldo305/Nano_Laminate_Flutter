import 'package:flutter/material.dart';
import 'package:nano_laminate/model/archive_model.dart';

class ArchiveView extends StatefulWidget {

  final Archive archive;
  
  const ArchiveView({super.key, required this.archive});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.archive.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Navigator.pushNamed(context, 'file_upload_view', arguments: widget.archive);
            },
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
      ),
    );
  }

}