import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/providers/archive_provider.dart';

part 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {

  final ArchiveProvider archiveProvider = ArchiveProvider();

  ArchiveBloc() : super(const ArchiveState()) {

    on<NewListArchiveEvent>((event, emit) {

      emit(state.copyWith(
        archives: event.archives
      ));

    });

    on<NewArchiveEvent>((event, emit) {

      emit(state.copyWith(
        archives: [...state.archives, event.archive]
      ));

    });

  }

  Future getArchives() async {

    final List<Archive> archives = await archiveProvider.getArchives();
    debugPrint(" archives bloc: $archives");
    add(NewListArchiveEvent(archives));

  }

  Future addArchive(Archive archive) async {

    final Archive archiveResp = await archiveProvider.postArchives(archive);
    add(NewArchiveEvent(archiveResp));

  }

}
