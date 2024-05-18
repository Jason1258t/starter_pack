import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../remote/api/service/models/token_model.dart';

part 'services/storage.dart';

part 'services/token_storage.dart';

class PreferencesService {
  /// Необходимо проверить готов ли сервис к работе
  late final Future initialized;
  late final SharedPreferences _prefs;

  PreferencesService() {
    initialized = SharedPreferences.getInstance().then((value) {
      _prefs = value;
      _storages.add(TokenStorage(_prefs));
    });
  }

  final List<Storage> _storages = [];

  T getStorage<T extends Storage>() =>
      _storages.firstWhere((element) => element is T) as T;

  Future saveToken(Token token) => getStorage<TokenStorage>().saveToken(token);

  Future<Token> getToken() => getStorage<TokenStorage>().getToken();

  Future logout() async {
    _prefs.clear();
  }

// ---------------------------------------------------------------
}
