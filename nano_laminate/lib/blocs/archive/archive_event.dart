part of 'archive_bloc.dart';

abstract class ArchiveEvent {
  const ArchiveEvent();
}

class NewListArchiveEvent extends ArchiveEvent {

  final List<Archive> archives;

  const NewListArchiveEvent(this.archives);

}

class NewArchiveEvent extends ArchiveEvent {

  final Archive archive;

  const NewArchiveEvent(this.archive);

}