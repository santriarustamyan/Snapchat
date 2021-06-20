import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship0006/classes/localizations.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/view_form/viewUser.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_user/edit_user_screen.dart';

class ProfilePageUserScreen extends StatefulWidget {
  ProfilePageUserScreen({required this.user});
  final User? user;
  @override
  _ProfilePageUserScreenState createState() => _ProfilePageUserScreenState();
}

class _ProfilePageUserScreenState extends State<ProfilePageUserScreen> {
  User? get _user => widget.user;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Scaffold(
          body: Stack(children: [
            SingleChildScrollView(
              child: _renderViewUserDataList(),
            ),
            _renderButtonEdit(),
            _renderQuitButton(),
          ]),
        )));
  }

  Widget _renderViewUserDataList() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 45,
        bottom: 40,
      ),
      child: Column(
        children: [
          _userField("FIRST_NAME", _user?.userFirstname),
          _userField("LAST_NAME", _user?.userLastname),
          _userField("USERNAME", _user?.username!),
          _userField("BIRTHDAY", _user?.userBirthday?.substring(0, 10)),
          _userField("EMAIL", _user?.userEmail),
          _userField("MOBILE_PHONE", _user?.userPhoneNumber),
        ],
      ),
    );
  }

  Widget _userField(String text, String? value) {
    return ViewUser(
      head: text.localizations(context),
      val: value == null ? "-" : value,
    );
  }

  Widget _renderButtonEdit() {
    return Container(
        padding: EdgeInsets.only(top: 15),
        alignment: Alignment.topRight,
        child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
              size: 32,
            ),
            onPressed: () => _editAction()));
  }

  Widget _renderQuitButton() {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: Colors.blue,
          text: "quit".localizations(context),
          onPress: () {
            _quitAction();
          },
        ));
  }

  void _editAction() {
    
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditUserDataScreen(user: _user)));
    
  }

  void _quitAction() {
    Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);

    _clearToken();
  }
}

_clearToken() async {
  var prefs = await SharedPreferences.getInstance();
   prefs.remove("token");
}
