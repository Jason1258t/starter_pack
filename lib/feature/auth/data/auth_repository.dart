import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../../utils/utils.dart';

class AuthRepository {
  AuthRepository() {

  }

  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject.seeded(AppStateEnum.wait);

  StreamSubscription? authSubscription;

  Future login(String email, code) async {}

  Future getCode(String email) async {}

  Future signOut() async {}
}
