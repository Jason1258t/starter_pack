part of '../preferences.dart';

class TokenStorage extends Storage {
  TokenStorage(super.prefs);

  static const String _tokenKey = 'token';

  Future saveToken(Token token) async {
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  Future<Token> getToken() async {
    final String? jwt = _prefs.getString(_tokenKey);
    if (jwt == null) return Token.zero();
    final Token token = Token.fromJson(jsonDecode(jwt));
    return token;
  }
}
