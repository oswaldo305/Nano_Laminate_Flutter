part of 'user_bloc.dart';

class UserState extends Equatable {

  final Usuario? user;

  const UserState({
    this.user
  });

  UserState copyWith({
    Usuario? user
  }) => UserState(
    user: user ?? this.user
  );
  
  @override
  List<Object?> get props => [user];
}
