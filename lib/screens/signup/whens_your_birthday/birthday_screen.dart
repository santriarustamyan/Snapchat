import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_screen.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_bloc.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_event.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_state.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:intl/intl.dart';
import 'package:internship0006/classes/localizations.dart';

class BirthDateScreen extends StatefulWidget {
  BirthDateScreen({this.user});
  final User? user;
  @override
  _BirthDatecreenState createState() => _BirthDatecreenState();
}

class _BirthDatecreenState extends State<BirthDateScreen> {
  User? get _user => widget.user;
  late DateTime _selectedDate;
  late BirthDayBloc _userBirthDayBloc;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userBirthDayBloc = BirthDayBloc();
  }

  @override
  void dispose() {
    _userBirthDayBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BirthDayBloc>(
      create: (context) {
        return _userBirthDayBloc;
      },
      child: _render(),
    );
  }

  Widget _render() {
    return BlocBuilder<BirthDayBloc, BirthDayState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Column(children: [
        HeadlineWidget(
          text: "When's_your_birthday?",
        ),
        Expanded(
          child: _setBirthData(state),
        ),
        _continueButton(state),
        Container(height: 200, width: double.infinity, child: setDatePicker())
      ])));
    });
  }

  Widget _setBirthData(BirthDayState state) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 80, right: 80, top: 10),
      child: TextField(
        autofocus: false,
        showCursor: false,
        controller: _textEditingController,
        decoration: InputDecoration(
            labelText: "Birth_Date".localizations(context),
            errorText: (state is BirthDayInvalidState)
                ? state.message.localizations(context)
                : null),
      ),
    );
  }

  Widget setDatePicker() {
    return Container(
        child: CupertinoDatePicker(
            initialDateTime: DateTime(DateTime.now().year - 16,
                DateTime.now().month, DateTime.now().day),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime dateTime) =>
                _changeDateTime(dateTime)));
  }

  Widget _continueButton(BirthDayState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: state is BirthDayValidatedState ? Colors.blue : Colors.grey,
          text: "Continue".localizations(context),
          onPress: () async {
            if (state is BirthDayValidatedState) {
              _sigmupAction();
            }
          },
        ));
  }

  void _changeDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      setState(() => _setDateTime(dateTime));
    }
  }

  void _setDateTime(DateTime dateTime) {
    _textEditingController.text = DateFormat("yyyy/MM/dd").format(dateTime);
    _userBirthDayBloc.add(BirthDayButtonValidationEvent(
        userBirthDay: _textEditingController.text));
    _selectedDate = dateTime;
  }

  void _sigmupAction() {
    _user!.userBirthday = DateFormat("yyyy-MM-dd").format(_selectedDate);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PickUserNameScreen(user: _user)));
  }
}
