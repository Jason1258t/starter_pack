import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/utils.dart';
import '../../data/auth_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;

  AppCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(AppInitial()) {
    subscribe();
  }

  void subscribe() {
    _authRepository.appState.stream.listen((event) async {
      if (event == AppStateEnum.auth) {
        emit(AppAuthState());
      }
      if (event == AppStateEnum.unAuth) {
        emit(AppUnAuthState());
      }
      if (event == AppStateEnum.wait) emit(AppInitial());
    });
  }
}
