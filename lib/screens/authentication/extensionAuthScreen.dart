import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internship0006/screens/all_users/all_users_screen.dart';
import 'package:internship0006/screens/login/login/login_screen.dart';
import 'package:internship0006/screens/signup/fullName/fullName_screen.dart';

enum AuthType { login, signUp, allUsers }

extension AuthAddition on AuthType {
  Color color() {
    switch (this) {
      case AuthType.login:
        return Colors.red;

      case AuthType.signUp:
        return Colors.blue;

      case AuthType.allUsers:
        return Colors.green;

      default:
        return Colors.black;
    }
  }

  String text() {
    switch (this) {
      case AuthType.login:
        return "LOG_IN";

      case AuthType.signUp:
        return "SING_UP";

      case AuthType.allUsers:
        return "ALL_USERS";

      default:
        return "";
    }
  }

  Widget child() {
    switch (this) {
      case AuthType.login:
        return LoginScreen();

      case AuthType.signUp:
        return FullNameScreen();

      case AuthType.allUsers:
        return AllUserScreen();

      default:
        return Container();
    }
  }
}
