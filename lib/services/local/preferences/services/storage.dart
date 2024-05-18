part of '../preferences.dart';

abstract class Storage {
  final SharedPreferences _prefs;

  Storage(this._prefs);
}
