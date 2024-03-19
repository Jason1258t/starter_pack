

import 'utils.dart';

abstract class Validator {
  static email(String? value) {
    if (!RegExp(AppStrings.emailRegExp).hasMatch((value ?? "").trim()) ||
        (value ?? "").isEmpty) {
      return 'Неверный email';
    } else {
      return null;
    }
  }

  static password(value) {
    if (value.length < 3) {
      return 'Слишком короткий';
    }

    return null;
  }

  static equal(String one, String two) {
    return one == two;
  }

  static name(String name) {
    if (name.length >= 3) {
      return null;
    } else {
      return 'Длина имени должна быть больше трех';
    }
  }

  static phone(String phone) {
    if (phone.length < 12) {
      return "Слишком короткий";
    }

    if (phone.length > 14) {
      return "Слишком длинный";
    }

    if (phone.substring(0, 1) != '+') {
      return "Номер начинается с +";
    }
  }

  static code(String code) {
    return code.length != 6 ? "Неправильный формат кода" : null;
  }
}
