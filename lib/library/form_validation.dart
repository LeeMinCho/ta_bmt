import 'package:validators/validators.dart';

class Validation {
  String validateRequired(String value) {
    if (value.isEmpty) {
      return 'Field ini harus diisi';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Field email harus diisi';
    } else if (isEmail(value) == false) {
      return 'Email tidak valid';
    } else {
      return null;
    }
  }
}
