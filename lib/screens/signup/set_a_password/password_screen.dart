import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/signup/email_or_phone/email_or_phone_screen.dart';
import 'package:internship0006/screens/signup/set_a_password/password_bloc.dart';
import 'package:internship0006/screens/signup/set_a_password/password_event.dart';
import 'package:internship0006/screens/signup/set_a_password/password_state.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/widgets/richText_Widget.dart';
import 'package:internship0006/widgets/txt_field.dart';
import 'package:internship0006/classes/localizations.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({this.user});
  final User? user;
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  User? get _user => widget.user;
  late PasswordBloc _passwordBloc;
  String password = "";
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _passwordBloc = PasswordBloc();
  }

  @override
  void dispose() {
    _passwordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordBloc>(
      create: (context) {
        return _passwordBloc;
      },
      child: _render(),
    );
  }

  Widget _render() {
    return BlocBuilder<PasswordBloc, PasswordState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            child: _renderMainOnScreen(state),
          ),
          _renderButtonContinue(state),
          HeadlineWidget(
            text: "Set_a_password",
          ),
        ]),
      ));
    });
  }

  _renderMainOnScreen(PasswordState state) {
    return Padding(
      padding: EdgeInsets.only(
        top: 80,
        bottom: 40,
      ),
      child: Column(
        children: [
          _renderPromptText(),
          _renderTxtFieldForScreenPassword(state),
        ],
      ),
    );
  }

  Widget _renderPromptText() {
    return RichTextWidget(
      text: "Your_password_should_be_at_least_8",
    );
  }

  Widget _renderTxtFieldForScreenPassword(PasswordState state) {
    return TxtFieldForScreen(
        txtType: TextInputType.emailAddress,
        label: "PASSWORD".localizations(context),
        obscure: _isObscure,
        suffixIcon: _renderShowIcon(),
        validator: (val) => _validator(val!, state),
        onChange: (val) => _onChangePassword(val));
  }

  Widget _renderShowIcon() {
    return TextButton(
        child: Text(_isObscure
            ? "Show".localizations(context)
            : "Hide".localizations(context)),
        onPressed: () => setState(() => _changeState()));
  }

  Widget _renderButtonContinue(PasswordState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: state is PasswordValidatedState ? Colors.blue : Colors.grey,
          text: "Continue".localizations(context),
          onPress: () {
            if (state is PasswordValidatedState) {
              _continueAction();
            }
          },
        ));
  }

  void _changeState() {
    _isObscure = !_isObscure;
  }

  void _onChangePassword(String val) {
    password = val;
    _passwordBloc.add(PasswordButtonValidationEvent(
      password: val,
    ));
  }

  String? _validator(String val, PasswordState state) {
    if (state is PasswordInvalidState) {
      return state.message.localizations(context).toUpperCase();
    }
    return null;
  }

  void _continueAction() {
    _user!.userPassword = password;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmailOrPhoneScreen(user: _user!)));
  }
}
