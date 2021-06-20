import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/all_users/all_users_cubit.dart';
import 'package:internship0006/screens/all_users/all_users_state.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/classes/localizations.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import '../profile_page_user_screen.dart';

class AllUserScreen extends StatefulWidget {
  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {


late List<User> _users;

 late AllUserCubit  _allUserCubit  ;
  @override
  void initState() {
    super.initState();
     _users= [];
     _allUserCubit = AllUserCubit();
    _allUserCubit.getAllUser();
  }

  @override
  void dispose() {
    _allUserCubit.close();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    return BlocProvider<AllUserCubit>(
        create: (context) {
          return _allUserCubit;
        },
        child: BlocListener<AllUserCubit, AllUserState>(
          listener: _blocListner,
          child: _build(context),
        ));
  }


  void _blocListner(context, state) {
    if (state is AllUsersState) {
      _users = state.users;
      setState(() {});
    }
  }

  Widget _build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 40,
          ),
          child: Column(
            children: [
              for (var i = 0; i < _users.length; i++) _viewUserButton(i),
            ],
          ),
        ),
        HeadlineWidget(
          backButton: false,
          text: "USERS",
        ),
        signUpButton(),
      ]),
    ));
  }

  Widget _viewUserButton(i) {
    return Container(
        alignment: Alignment.center,
        child: ContinueButton(
          color: Colors.grey,
          text: "${i + 1}    ${_users[i].username}",
          onPress: () async {
            _viewUserAction(_users[i]);
          },
        ));
  }

  Widget signUpButton() {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: Colors.blue,
          text: "OK".localizations(context),
          onPress: () async {
            _sigmupAction();
          },
        ));
  }

  void _sigmupAction() {
     Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
  }

  void _viewUserAction(User _user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePageUserScreen(user: _user)));
  }
}
