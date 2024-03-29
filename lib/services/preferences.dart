import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'api/service/models/token_model.dart';

class PreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const String _tokenKey = 'token';
  static const String _pinCodeKey = 'pin';
  static const String _seedPhraseKey = 'seed';
  static const String _emailKey = 'email';
  static const String _inviteCodeKey = 'invite_code';
  static const String _placeIdKey = 'place_id';

  static const String _walletStatesKey = 'wallet_state';
  static const String _createdWallet = 'CREATED';
  static const String _watchSeed = 'WATCH_SEED';
  static const String _confirmedWallet = 'CONFIRMED';

  Future saveToken(Token token) async {
    final prefs = await _prefs;
    await prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  Future<Token> getToken() async {
    final prefs = await _prefs;
    final String? jwt = prefs.getString(_tokenKey);
    if (jwt == null) return Token.zero();
    final Token token = Token.fromJson(jsonDecode(jwt));
    return token;
  }

  Future<void> setPinCode(String pinCode, String email) async {
    final storage = await _getPinStorage();
    storage[email] = pinCode;
    await _setPinStorage(storage);
  }

  Future<String?> getPinCode(String email) async {
    final json = await _getPinStorage();
    return json[email];
  }

  Future setWalletState(WalletCreationState state, String email) async {
    String stringState = _walletStateToString(state);

    final wallets = await _getWalletStateMap();
    wallets[email] = stringState;

    await _saveWalletStates(wallets);
  }

  Future<WalletCreationState?> getWalletState(String email) async {
    final wallets = await _getWalletStateMap();

    if (!wallets.containsKey(email)) return null;

    return _walletStringToState(wallets[email] as String);
  }

  Future<void> setSeedPhrase(
      {required String seedPhrase, required String email}) async {
    final prefs = await _prefs;

    Map<String, dynamic> seedStorage = await getSeedPhrase() ?? {};
    seedStorage[email] = seedPhrase;

    String encodedSeed = jsonEncode(seedStorage);

    await prefs.setString(_seedPhraseKey, encodedSeed);
  }

  Future<Map<String, dynamic>?> getSeedPhrase() async {
    final prefs = await _prefs;
    final String? encodedSeedStorage = prefs.getString(_seedPhraseKey);
    if (encodedSeedStorage == null) {
      return null;
    }

    Map<String, dynamic> seedStorage = jsonDecode(encodedSeedStorage);
    return seedStorage;
  }

  Future<void> setEmail(String email) async {
    final prefs = await _prefs;
    await prefs.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString(_emailKey);
  }

  Future<void> setInviteCode(String code) async {
    final prefs = await _prefs;
    prefs.setString(_inviteCodeKey, code);
  }

  Future<String?> getInviteCode() async {
    final prefs = await _prefs;
    final code = prefs.getString(_inviteCodeKey);
    return code;
  }

  Future<void> setPlaceId(String code) async {
    final prefs = await _prefs;
    prefs.setString(_placeIdKey, code);
  }

  Future<String?> getPlaceId() async {
    final prefs = await _prefs;
    final code = prefs.getString(_inviteCodeKey);
    return code;
  }

  Future logout() async { // TODO проверить все ли нужное удаляется
    final prefs = await _prefs;

    await prefs.remove(_emailKey);
    await prefs.remove(_inviteCodeKey);
    await prefs.remove(_placeIdKey);
    await prefs.remove(_tokenKey);
  }

  // ---------------------------------------------------------------

  Future<Map<String, dynamic>> _getPinStorage() async {
    final prefs = await _prefs;
    final res = prefs.getString(_pinCodeKey) ?? '{}';
    final Map<String, dynamic> json = jsonDecode(res);
    return json;
  }

  Future<void> _setPinStorage(Map<String, dynamic> storage) async {
    final prefs = await _prefs;
    final json = jsonEncode(storage);
    prefs.setString(_pinCodeKey, json);
  }

  Future _saveWalletStates(Map<String, dynamic> wallets) async {
    final prefs = await _prefs;
    await prefs.setString(_walletStatesKey, jsonEncode(wallets));
  }

  Future<Map<String, dynamic>> _getWalletStateMap() async {
    final prefs = await _prefs;
    final res = prefs.getString(_walletStatesKey);
    if (res == null) return {};
    return jsonDecode(res);
  }


  String _walletStateToString(WalletCreationState state) {
    String stringState;

    switch (state) {
      case WalletCreationState.created:
        stringState = _createdWallet;
      case WalletCreationState.watchSeed:
        stringState = _watchSeed;
      case WalletCreationState.confirmed:
        stringState = _confirmedWallet;
    }

    return stringState;
  }

  WalletCreationState? _walletStringToState(String stringState) {
    switch (stringState) {
      case _createdWallet:
        return WalletCreationState.created;
      case _watchSeed:
        return WalletCreationState.watchSeed;
      case _confirmedWallet:
        return WalletCreationState.confirmed;
    }
    return null;
  }
}
