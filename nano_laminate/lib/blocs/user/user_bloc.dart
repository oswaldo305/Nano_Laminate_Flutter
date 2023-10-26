import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nano_laminate/model/usuario_model.dart';
import 'package:nano_laminate/providers/user_provider.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserProvider _userProvider = UserProvider();

  UserBloc() : super(const UserState()) {

    on<NewUserEvent>((event, emit) {

      emit(
        state.copyWith(user: event.user)
      );

    });

    on<LogOutUserEvent>((event, emit){

      emit(
        state.copyWith(user: null)
      );

    });

  }

  Future getUsuarioByUid(String uid) async {
    final usuario = await _userProvider.getUserbyUid(uid);
    add( NewUserEvent(usuario!) );
  }

  Future postUsuario(Usuario usuario) async {
    await _userProvider.postUser(usuario);
    add( NewUserEvent(usuario) );
  }

  void logOut(){
    add( LogOutUserEvent() );
  }

}
