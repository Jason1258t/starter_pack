import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../../services/local/preferences/preferences.dart';
import '../../../utils/enums.dart';

import '../../../services/remote/api/api_service.dart';

class AuthRepository {
  final PreferencesService _prefs;
  final ApiService _apiService;

  AuthRepository(this._prefs, this._apiService) {
    initialize();
  }

  void initialize() async {
    await _prefs.initialized;
    await _apiService.initialized;
    checkAuth();
  }

  void checkAuth() async {
    // TODO do smt
  }

  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject.seeded(AppStateEnum.wait);

  StreamSubscription? authSubscription;

  Future login(String email, code) async {}

  Future signOut() async {}
}
