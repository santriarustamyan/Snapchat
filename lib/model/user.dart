

import 'package:intl/intl.dart';

class User {
  String? id;
  String? userFirstname;
  String? userLastname;
  String? userBirthday;
  String? username;
  String? userPassword;
  String? userEmail;
  String? userPhoneNumber;

  User(
      {this.userFirstname,
      this.userLastname,
      this.userBirthday,
      this.username,
      this.userPassword,
      this.userEmail,
      this.userPhoneNumber,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userFirstname = json['firstName'];
    userLastname = json['lastName'];
    userPassword = json['password'];
    userEmail = json['email'];
    userPhoneNumber = json['phone'];
    username = json['name'];
    userBirthday =json['birthDate'];    
    // userBirthday = DateTime.parse(json['birthDate']).formattedDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['firstName'] = this.userFirstname;
    data['lastName'] = this.userLastname;
    data['password'] = this.userPassword;
    data['email'] = this.userEmail;
    data['phone'] = this.userPhoneNumber;
    data['name'] = this.username;
    data['birthDate'] = this.userBirthday;
    return data;
  }
}
extension BirthDateFormat on DateTime {
  String formattedDate() => DateFormat('yyyy/MM/dd').format(this);
}