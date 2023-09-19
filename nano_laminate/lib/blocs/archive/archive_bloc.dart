import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  ArchiveBloc() : super(ArchiveInitial()) {
    on<ArchiveEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
