import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/classes/loading_country.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/edit_user/edit_user_bloc.dart';
import 'package:internship0006/screens/edit_user/edit_user_event.dart';
import 'package:internship0006/screens/edit_user/edit_user_state.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/classes/localizations.dart';
import 'package:internship0006/widgets/showAlert.dart';

import 'package:internship0006/widgets/txt_field.dart';
import 'package:intl/intl.dart';

class EditUserDataScreen extends StatefulWidget {
  EditUserDataScreen({this.user});
  final User? user;
  @override
  _EditUserDataScreenState createState() => _EditUserDataScreenState(user!);
}

class _EditUserDataScreenState extends State<EditUserDataScreen> {
  _EditUserDataScreenState(User user) {}

  TextEditingController _birthdayEditingController = TextEditingController();
  late EditUserDataBloc _editUserDataBloc;
  EditUserDataBloc get editUserDataBloc => _editUserDataBloc;
  User _copyUser = User();
  User? get user => editUserDataBloc.user;
  late DateTime _selectedDate;
  late DateTime _maximumDate;
  late DateTime _initialDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _editUserDataBloc = EditUserDataBloc();
    _birthdayEditingController.text =
        widget.user!.userBirthday!.substring(0, 10);
    _maximumDate = DateTime.now();
    _initialDateTime = DateTime(
        DateTime.now().year - 16, DateTime.now().month, DateTime.now().day);

    _copyUser = User()
      ..id = widget.user!.id
      ..userFirstname = widget.user!.userFirstname
      ..userLastname = widget.user!.userLastname
      ..userBirthday = widget.user!.userBirthday!
      ..username = widget.user!.username
      ..userPassword = widget.user!.userPassword
      ..userEmail = widget.user!.userEmail
      ..userPhoneNumber = widget.user!.userPhoneNumber;
  }

  @override
  void dispose() {
    editUserDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditUserDataBloc>(
        create: (context) {
          return editUserDataBloc;
        },
        child: BlocListener<EditUserDataBloc, EditUserDataState>(
          listener: _blocListener,
          child: _render(),
        ));
  }

  Widget _render() {
    return BlocBuilder<EditUserDataBloc, EditUserDataState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 70,
            ),
            child: _renderviewUserDataList(state),
          ),
          _okButton(state),
        ]),
      ));
    });
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        late DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text("Cancel".localizations(context)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: Text("Done".localizations(context)),
                      onPressed: () =>
                          Navigator.of(context).pop(tempPickedDate),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                    maximumDate: _maximumDate,
                    initialDateTime: _initialDateTime,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _birthdayEditingController.text =
          DateFormat("yyyy/MM/dd").format(pickedDate);
      _copyUser.userBirthday = _birthdayEditingController.text;
      editUserDataBloc.add(ValidationEvent(
          originalUser: widget.user!,
          value: _birthdayEditingController.text,
          inputType: InputType.birthDay,
          copyUser: user));
    }
  }

  Widget _inputBirthday(EditUserDataState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
        right: 35,
      ),
      child: GestureDetector(
        onTap: () => _selectDate(),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _birthdayEditingController,
            decoration: InputDecoration(
              labelText: "BIRTHDAY".localizations(context).toUpperCase(),
              errorText: (state is BirthDayInvalidState)
                  ? state.message.localizations(context)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _okButton(EditUserDataState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 10),
        child: ContinueButton(
          color: Colors.blue,
          text: "OK".localizations(context),
          onPress: () async {
            IconLoadCountry.showLoading(context);
            editUserDataBloc.add(OKButtonValidationEvent(
                originalUser: widget.user!, copyUser: _copyUser));
          },
        ));
  }

  Widget _renderviewUserDataList(EditUserDataState state) {
    return Container(
      child: Column(
        children: [
          _userField(
              state, "FIRST_NAME".localizations(context), InputType.firstName),
          _userField(
              state, "LAST_NAME".localizations(context), InputType.lastName),
          _inputBirthday(state),
          _userField(
              state, "USERNAME".localizations(context), InputType.userName),
          _userField(
              state, "PASSWORD".localizations(context), InputType.password),
          _userField(state, "EMAIL".localizations(context), InputType.email),
          _userField(state, "MOBILE_PHONE".localizations(context),
              InputType.mobNumber),
        ],
      ),
    );
  }

  Widget _userField(
    EditUserDataState state,
    String text,
    InputType inputType,
  ) {
    return TxtFieldForScreen(
      initialValue: _initialText(inputType),
      label: text.toUpperCase(),
      obscure: false,
      validator: (_) => _validation(state, context, inputType),
      onChange: (val) {
        _initType(inputType, val);
        editUserDataBloc.add(ValidationEvent(
            value: val,
            inputType: inputType,
            copyUser: _copyUser,
            originalUser: widget.user!));
      },
    );
  }

  String? _initialText(InputType inputType) {
    switch (inputType) {
      case InputType.firstName:
        return _copyUser.userFirstname;

      case InputType.lastName:
        return _copyUser.userLastname;

      case InputType.birthDay:
        return _copyUser.userBirthday;

      case InputType.userName:
        return _copyUser.username;

      case InputType.email:
        return _copyUser.userEmail;

      case InputType.password:
        return _copyUser.userPassword;

      case InputType.mobNumber:
        return _copyUser.userPhoneNumber;

      default:
        return null;
    }
  }

  void _initType(InputType inputType, String val) {
    if (inputType == InputType.firstName) _copyUser.userFirstname = val;
    if (inputType == InputType.lastName) _copyUser.userLastname = val;
    if (inputType == InputType.password) _copyUser.userPassword = val;
    if (inputType == InputType.userName) _copyUser.username = val;
    if (inputType == InputType.birthDay) _copyUser.userBirthday = val;
    if (inputType == InputType.email) _copyUser.userEmail = val;
    if (inputType == InputType.mobNumber) _copyUser.userPhoneNumber = val;
  }

  String? _validation(EditUserDataState state, context, InputType inputType) {
    switch (inputType) {
      case InputType.firstName:
        if (state is InvalidFirstnameState)
          return state.message.localizations(context);
        break;
      case InputType.lastName:
        if (state is InvalidLastnameState)
          return state.message.localizations(context);
        break;
      case InputType.birthDay:
        if (state is BirthDayInvalidState)
          return state.message.localizations(context);
        break;
      case InputType.userName:
        if (state is UserNameInvalidState)
          return state.message.localizations(context);
        break;
      case InputType.password:
        if (state is PasswordInvalid)
          return state.message.localizations(context);
        break;
      case InputType.email:
        if (state is EmailInvalidState)
          return state.message.localizations(context);
        break;
      case InputType.mobNumber:
        if (state is MobileNumInvalidState)
          return state.message.localizations(context);
        break;
    }
    return null;
  }

  void _showDialog(String massege) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("error"),
          content: new Text(massege),
          actions: <Widget>[
            new TextButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _blocListener(BuildContext context, EditUserDataState state) {
    if (state is EditUserDataValidatedState) {
      editUserDataBloc.add(UserEditEvent(
        user: _copyUser,
      ));
    }

    if (state is FormIsFinalInvalid) {
      // Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
      _showDialog(state.invalidErrorMassege.localizations(context));
    }
    if (state is UserIsUpdatedState) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
    }
    if (state is UserIsNotUpdatedState) {
      String _loginError = state.errorMessage;
      showAlertDialog(context,
          title: "Login Failed ...",
          content: _loginError,
          onPressButton: onAlertButtonPress);
    }
  }

  void onAlertButtonPress() => Navigator.pop(context);
}

enum InputType {
  firstName,
  lastName,
  birthDay,
  userName,
  password,
  email,
  mobNumber
}
