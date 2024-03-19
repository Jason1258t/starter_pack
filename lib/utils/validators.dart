

import 'utils.dart';

abstract class Validator {
  static String? email(String? value) {
    if (!RegExp(AppStrings.emailRegExp).hasMatch((value ?? "").trim()) ||
        (value ?? "").isEmpty) {
      return 'Неверный email';
    } else {
      return null;
    }
  }

  static String? password(value) {
    if (value.length < 3) {
      return 'Слишком короткий';
    }

    return null;
  }

  static equal(String one, String two) {
    return one == two;
  }

  static String? name(String name) {
    if (name.length >= 3) {
      return null;
    } else {
      return 'Длина имени должна быть больше трех';
    }
  }

  static String? phone(String phone) {
    if (phone.length < 12) {
      return "Слишком короткий";
    }

    if (phone.length > 14) {
      return "Слишком длинный";
    }

    if (phone.substring(0, 1) != '+') {
      return "Номер начинается с +";
    }
    return null;
  }

  static String? code(String code) {
    return code.length != 6 ? "Неправильный формат кода" : null;
  }
}
