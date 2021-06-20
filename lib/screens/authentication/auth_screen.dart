import 'package:flutter/material.dart';
import 'package:internship0006/classes/localizations.dart';
import 'package:internship0006/screens/authentication/extensionAuthScreen.dart';
import 'package:internship0006/screens/authentication/photo/myPhotoScreen.dart';
import 'package:internship0006/widgets/auth_button.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: _render());
  }

  Widget _render() {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _renderLogoSnapchat(),
            Expanded(
              child: _renderMyphoto(),
            ),
            Container(
              child: Column(
                children: [
                  _renderAuthButton(AuthType.login),
                  _renderAuthButton(AuthType.signUp),
                  _renderAuthButton(AuthType.allUsers),
                ],
              ),
            )
          ],
        ));
  }

  Widget _renderLogoSnapchat() {
    return Padding(
        padding: EdgeInsets.only(top: 100, bottom: 10),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset("assets/logo.png"),
          height: 160,
        ));
  }

  Widget _renderMyphoto() {
    return Padding(
        padding: EdgeInsets.only(top: 50, bottom: 20),
        child: Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPhotoScreen()));
              },
              child: Text(
                "My Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )));
  }

  Widget _renderAuthButton(AuthType type) {
    return TextAuthButton(
        color: type.color(),
        text: type.text().localizations(context),
        onPress: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => type.child()));
        });
  }
}
