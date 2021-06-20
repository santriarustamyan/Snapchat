import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internship0006/model/user.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserNetworkRepository {
  Future<String?> insertUserDB(User user) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/addUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        "firstName": user.userFirstname,
        "lastName": user.userLastname,
        "password": user.userPassword,
        "email": user.userEmail,
        "name": user.username,
        "birthDate": user.userBirthday,
        "phone": user.userPhoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      prefs.setString(
          "token", jsonDecode(response.body)["createdTokenForUser"]);

      final body = json.decode(response.body)["user"];
      return body["_id"];
    } else {
      throw Exception('Don`t Add User');
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http
        .get(Uri.parse('https://parentstree-server.herokuapp.com/allUsers'));

    if (response.statusCode == 200) {
      final parsed =
          jsonDecode(response.body)["users"].cast<Map<String, dynamic>>();

      return parsed.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('  ');
    }
  }

  Future<bool> checkUsername(User user) async {
    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/check/name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        "name": user.username,
      }),
    );

    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkMobilePhone(User user) async {
    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/check/phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        "phone": user.userPhoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkEmail(User user) async {
    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/check/email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        "email": user.userEmail,
      }),
    );

    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> updateUsers(User _user) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/editAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "token": token
      },
      body: jsonEncode(<String, String?>{
        "firstName": _user.userFirstname,
        "lastName": _user.userLastname,
        "password": _user.userPassword,
        "email": _user.userEmail,
        "name": _user.username,
        "birthDate": _user.userBirthday,
        "phone": _user.userPhoneNumber,
      }),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<User?> login(String usernameOrEmail, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse('https://parentstree-server.herokuapp.com/signIn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        "login": usernameOrEmail,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      prefs.setString(
          "token", jsonDecode(response.body)["createdTokenForUser"]);

      return User.fromJson(jsonDecode(response.body)["user"]);
    } else {
      throw Exception('Invalid email or Password');
    }
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    final Response response = await http.get(
      Uri.parse('https://parentstree-server.herokuapp.com/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'token': token ?? ""
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)["user"]);
    } else {
      throw Exception('Failed to update a case');
    }
  }
}
