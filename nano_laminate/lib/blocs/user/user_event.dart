part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class NewUserEvent extends UserEvent{

  final Usuario user;

  const NewUserEvent(this.user);

}

class LogOutUserEvent extends UserEvent {}
