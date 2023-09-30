part of 'archive_bloc.dart';

class ArchiveState extends Equatable {

  final List<Archive> archives;

  const ArchiveState({
    archives
  }): archives = archives ?? const [];

  ArchiveState copyWith({
    List<Archive> ? archives
  }) => ArchiveState(
    archives: archives ?? this.archives
  );

  @override
  List<Object?> get props => [archives];

}
