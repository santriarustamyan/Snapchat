import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/signup/fullName/fullName_bloc.dart';
import 'package:internship0006/screens/signup/fullName/fullName_event.dart';
import 'package:internship0006/screens/signup/fullName/fullName_state.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_screen.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/widgets/html_text.dart';
import 'package:internship0006/widgets/txt_field.dart';
import 'package:internship0006/classes/localizations.dart';

class FullNameScreen extends StatefulWidget {
  @override
  _FullNameScreenState createState() => _FullNameScreenState();
}

class _FullNameScreenState extends State<FullNameScreen> {
  User? get _user => _fullNameBloc.user;
  late FullNameBloc _fullNameBloc;
   String lastName= "";
   String firstName="";

  @override
  void initState() {
    super.initState();
    _fullNameBloc = FullNameBloc();
  }

  @override
  void dispose() {
    _fullNameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FullNameBloc>(
      create: (context) {
        return _fullNameBloc;
      },
      child: _render(),
    );
  }

  Widget _render() {
    return BlocBuilder<FullNameBloc, FullNameState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Stack(children: [
        SingleChildScrollView(
          child: _renderMainOnScreen(state),
        ),
        _signUpButton(state),
        HeadlineWidget(
          text: "What's_your_name?",
        ),
      ])));
    });
  }

  Widget _renderMainOnScreen(FullNameState state) {
    return Padding(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          _renderTextForFirstName(state),
          _renderTextForLastName(state),
          HtemText(),
        ],
      ),
    );
  }

  Widget _renderTextForFirstName(FullNameState state) {
    return Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: TxtFieldForScreen(
            txtType: TextInputType.name,
            label: "FIRST_NAME".localizations(context),
            obscure: false,
            validator: (_) {
              return state is InvalidFirstnameState
                  ? state.message.localizations(context)
                  : null;
            },
            onChange: (val) => _onChangeFrstName(val)));
  }

  Widget _renderTextForLastName(FullNameState state) {
    return Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: TxtFieldForScreen(
          txtType: TextInputType.name,
          label: "LAST_NAME".localizations(context),
          obscure: false,
          validator: (_) {
            return state is InvalidLastnameState
                ? state.message.localizations(context)
                : null;
          },
          onChange: (val) => _onChangeLastName(val),
        ));
  }

  Widget _signUpButton(FullNameState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: state is FullNameValidatedState ? Colors.blue : Colors.grey,
          text: "Sign_Up_&_Accept".localizations(context),
          onPress: () {
            if (state is FullNameValidatedState) {
              _sigmupAction();
            }
          },
        ));
  }

  void _onChangeFrstName(String val) {
    firstName = val;
    _fullNameBloc
        .add(FullNameButtonValidationEvevt(firstName: val, lastName: lastName));
  }

  void _onChangeLastName(String val) {
    lastName = val;
    _fullNameBloc.add(
        FullNameButtonValidationEvevt(firstName: firstName, lastName: val));
  }

  void _sigmupAction() {
    _user!.userLastname = lastName;
    _user!.userFirstname = firstName;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BirthDateScreen(user: _user)));
  }
}
