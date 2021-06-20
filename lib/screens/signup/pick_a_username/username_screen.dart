import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_bloc.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_event.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_state.dart';
import 'package:internship0006/screens/signup/set_a_password/password_screen.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/widgets/richText_Widget.dart';
import 'package:internship0006/widgets/txt_field.dart';
import 'package:internship0006/classes/localizations.dart';

class PickUserNameScreen extends StatefulWidget {
  PickUserNameScreen({this.user});
  final User? user;
  @override
  _PickUserNameScreenState createState() => _PickUserNameScreenState();
}

class _PickUserNameScreenState extends State<PickUserNameScreen> {
  User? get _user => widget.user;
  late UserNameBloc _usernameBloc;
  String userName = "";
  @override
  void initState() {
    super.initState();
    _usernameBloc = UserNameBloc();
  }

  @override
  void dispose() {
    _usernameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserNameBloc>(
        create: (context) {
          return _usernameBloc;
        },
        child: BlocListener<UserNameBloc, UserNameState>(
          listener: _blocListtener,
          child: _render(),
        ));
  }

  Widget _render() {
    return BlocBuilder<UserNameBloc, UserNameState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Stack(children: [
        SingleChildScrollView(
          child: _renderMainOnScreen(state),
        ),
        _renderUserButtonContinue(state),
        HeadlineWidget(
          text: "Pick_a_username",
        ),
      ])));
    });
  }

  Widget _renderMainOnScreen(UserNameState state) {
    return Padding(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          _renderPromptText(),
          _renderTxtFieldForScreenUserName(state),
        ],
      ),
    );
  }

  Widget _renderPromptText() {
    return RichTextWidget(
      text: "Your_username_is_how_friends_add_you",
    );
  }

  Widget _renderTxtFieldForScreenUserName(UserNameState state) {
    return TxtFieldForScreen(
        txtType: TextInputType.text,
        label: "USERNAME".localizations(context),
        obscure: false,
        validator: (val) => _validator(val!, state),
        onChange: (val) => _onChangeUsername(val));
  }

  Widget _renderUserButtonContinue(UserNameState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
            color: state is UserNameValidatedState ? Colors.blue : Colors.grey,
            text: "Continue".localizations(context),
            onPress: () => _continueAction(state)));
  }

  String? _validator(String val, UserNameState state) {
    if (state is UserNameInvalidState) {
      return state.message.localizations(context).toUpperCase();
    }
    return null;
  }

  void _blocListtener(context, state) {
    if (state is UserNameValidatedState) {
      _usernameBloc.add(UserNameExistsEvent(userName: userName));
    }
  }

  void _onChangeUsername(String val) {
    userName = val;
    widget.user!.username = val;
    _usernameBloc.add(UserNameButtonValidationEvent(
      user: widget.user!,
    ));
  }

  void _continueAction(state) {
    if (state is UserNameValidatedState) {
      _user!.username = userName;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SetPasswordScreen(
                    user: _user,
                  )));
    }
  }
}
