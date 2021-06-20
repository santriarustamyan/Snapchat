import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/country.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/widgets/headline_Widget.dart';
import 'package:internship0006/widgets/continue_button.dart';
import 'package:internship0006/widgets/richText_Widget.dart';
import 'package:internship0006/widgets/showAlert.dart';
import 'package:internship0006/widgets/txt_field.dart';
import '../../profile_page_user_screen.dart';
import 'countries_buton/countries_screen.dart';
import 'email_or_phone_bloc.dart';
import 'email_or_phone_event.dart';
import 'email_or_phone_state.dart';
import 'package:internship0006/classes/localizations.dart';

class EmailOrPhoneScreen extends StatefulWidget {
  EmailOrPhoneScreen({required this.user});
  final User user;
  @override
  _EmailOrPhoneScreenState createState() => _EmailOrPhoneScreenState();
}

class _EmailOrPhoneScreenState extends State<EmailOrPhoneScreen> {
  String _loginError = "";
  String _userEmailOrPhone = "";
  User get _users => widget.user;
  User _user = User();
  late EmailOrPhoneBloc _emailOrPhoneBloc;
  bool isEmailScreenVisible = false;
  final CountryDetails details = CountryCodes.detailsForLocale();
  ValueNotifier<Country> countryNotifier = ValueNotifier<Country>(Country());

  @override
  void initState() {
    super.initState();
    countryNotifier.value.e164cc = details.dialCode!.substring(1);
    countryNotifier.value.iso2cc = details.alpha2Code;
    _emailOrPhoneBloc = EmailOrPhoneBloc();
  }

  @override
  void dispose() {
    _emailOrPhoneBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmailOrPhoneBloc>(
        create: (context) {
          return _emailOrPhoneBloc;
        },
        child: BlocListener<EmailOrPhoneBloc, EmailOrPhoneState>(
          listener: _emailOrPhoneBlocListtener,
          child: _render(),
        ));
  }

  Widget _render() {
    return BlocBuilder<EmailOrPhoneBloc, EmailOrPhoneState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: <Widget>[
            _renderMainOnScreenPhone(state),
            _renderMainOnScreenEmail(state),
          ]),
        ),
        HeadlineWidget(
          text: (!isEmailScreenVisible)
              ? "What's_your_mobile_number"
              : "Enter_your_email",
        ),
        _renderContinueButton(state),
      ])));
    });
  }

  Widget _renderTextforEmail(EmailOrPhoneState state) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: TextButton(
        onPressed: () => _emailOrPhoneBloc
            .add(EmailOrPhoneScreenChangeEvent(emailScreen: true)),
        child: Text(
          "Sign_up_with_phone_instead".localizations(context),
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _renderTextfornumberPhone() {
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () => _emailOrPhoneBloc
              .add(EmailOrPhoneScreenChangeEvent(emailScreen: false)),
          child: Text(
            "Sign_up_with_email_instead".localizations(context),
            style: TextStyle(color: Colors.blue),
          ),
        ));
  }

  Widget _renderMainOnScreenEmail(EmailOrPhoneState state) {
    return Visibility(
      maintainState: true,
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            _renderTextforEmail(state),
            _renderTxtFieldForScreen(state),
          ],
        ),
      ),
      visible: isEmailScreenVisible,
    );
  }

  Widget _renderMainOnScreenPhone(EmailOrPhoneState state) {
    return Visibility(
      maintainState: true,
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            _renderTextfornumberPhone(),
            _renderTxtFieldForScreenMobileNumPhone(state),
            _renderTextforsenssmsPhone(),
          ],
        ),
      ),
      visible: !isEmailScreenVisible,
    );
  }

  Widget _renderTxtFieldForScreen(EmailOrPhoneState state) {
    return TxtFieldForScreen(
        label: "EMAIL".localizations(context),
        obscure: false,
        validator: (val) => _validatorEmail(val!, state),
        onChange: (val) => _onchangeEmail(val));
  }

  Widget _renderTxtFieldForScreenMobileNumPhone(EmailOrPhoneState state) {
    return TxtFieldForScreen(
        txtType: TextInputType.phone,
        label: "MOBILE_NUMBER".localizations(context),
        obscure: false,
        preffix: _phoneCountryCodePhone(),
        validator: (val) =>
            _validatorPhone(countryNotifier.value.e164cc! + val!, state),
        onChange: (val) => _onchangeNumber(val));
  }

  Widget _renderTextforsenssmsPhone() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: RichTextWidget(
          text: "We'll_send_you_an_SMS_verification_code.",
          wrap: false,
          color: Colors.black87,
        ));
  }

  Widget _renderContinueButton(EmailOrPhoneState state) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsetsDirectional.only(bottom: 10),
      child: ContinueButton(
        color: state is EmailOrPhoneValidatedState ? Colors.blue : Colors.grey,
        text: "Continue".localizations(context),
        onPress: () {
          _continueAction(state);
        },
      ),
    );
  }

  Widget _phoneCountryCodePhone() {
    return ValueListenableBuilder(
      valueListenable: countryNotifier,
      builder: (context, value, child) => TextButton(
        onPressed: () {
          _pohoneActionPhone();
        },
        child: Text(
          "${countryNotifier.value.iso2cc} +${countryNotifier.value.e164cc} ",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  String? _validatorPhone(String val, EmailOrPhoneState state) {
    if (state is MobileNumInvalidState) {
      return state.message.localizations(context);
    }
    return null;
  }

  String? _validatorEmail(String val, EmailOrPhoneState state) {
    if (state is EmailInvalidState) {
      return state.message.localizations(context);
    }
    return null;
  }

  void _emailOrPhoneBlocListtener(context, state) {
    if (state is EmailOrPhoneValidatedState) {
      if (isEmailScreenVisible) {
        _emailOrPhoneBloc.add(EmailExistsEvent(email: _userEmailOrPhone));
      } else {
        _emailOrPhoneBloc
            .add(MobileNumExistsEvent(mobileNum: _userEmailOrPhone));
      }
    }
    if (state is UserIsAddState) {
      _users.id = state.id;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePageUserScreen(
                    user: _users,
                  )));
    }
    if (state is EmailScreenVisibilityState) {
      isEmailScreenVisible = false;
    }
    if (state is MobileNumScreenVisibilityState) {
      isEmailScreenVisible = true;
    }

    if (state is UserIsNotAddState) {
      _loginError = state.errorMessage;
      showAlertDialog(context,
          title: "Login Failed ...",
          content: _loginError,
          onPressButton: onAlertButtonPress);
    }
  }

  void _continueAction(EmailOrPhoneState state) {
    if (state is EmailOrPhoneValidatedState) {
      if (isEmailScreenVisible) {
        _users.userEmail = _userEmailOrPhone;
        _users.userPhoneNumber = "";
      } else {
        _users.userPhoneNumber = _userEmailOrPhone;
        _users.userEmail = "";
      }
      _emailOrPhoneBloc.add(UserAddEvent(user: _users));
    }
  }

  void _onchangeNumber(String val) {
    _userEmailOrPhone = "+${countryNotifier.value.e164cc}" + val;
    _user.userPhoneNumber = countryNotifier.value.e164cc! + val;
    _emailOrPhoneBloc.add(MobileNumButtonValidationEvent(
      user: _user,
    ));
  }

  void _onchangeEmail(String val) {
    _userEmailOrPhone = val;
    _user.userEmail = val;
    _emailOrPhoneBloc.add(EmailButtonValidationEvent(
      user: _user,
    ));
  }

  void _pohoneActionPhone() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryScreen(
                  countryNotifier: countryNotifier,
                )));
  }

  void onAlertButtonPress() => Navigator.pop(context);
}
