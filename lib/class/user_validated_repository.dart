import 'package:intl/intl.dart';

class UserValidatedRepository {
  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isAdult(String birthday) {    
    String datePattern = "yyyy/MM/dd";
    DateTime today = DateTime.now();
    DateTime birthDate = DateFormat(datePattern).parse(birthday);
    DateTime adultDate = DateTime(
      birthDate.year + 16,
      birthDate.month,
      birthDate.day,
    );
    return adultDate.isBefore(today);
  }

  bool isvalidData(String dataTime) {
    if (_isAdult(dataTime) && dataTime.isNotEmpty && !dataTime.contains(" ")) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPhone(String phone) {
    RegExp _phoneRegExp = RegExp(r'(^(?:[+)])?[0-9]{11,11}$)');
    if (_phoneRegExp.hasMatch(phone) && !phone.contains(" ")) {
      return true;
    }
    return false;
  }

  bool isValidPassword(String? password) {
    if (password == null || password.length < 8 || password.contains(" "))
      return false;
    return true;
  }

  bool isValidFirstname(String? firstname) {
    if (firstname == null || firstname.length < 1 || firstname.contains(" "))
      return false;
    return true;
  }

  bool isValidLastname(String? lastname) {
    if (lastname == null || lastname.length < 1 || lastname.contains(" "))
      return false;
    return true;
  }

  bool isValidUsername(String? username) {
    if (username == null || username.length < 6 || username.contains(" "))
      return false;
    return true;
  }
}
