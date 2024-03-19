import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AuthInitial());

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthInProcess());
    try {
      await _authRepository.login(email, password);
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthFailState(e));
    }
  }

  void signOut() => _authRepository.signOut();
}