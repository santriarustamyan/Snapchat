import 'package:bloc/bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:internship0006/class/user_validated_repository.dart';
import 'email_or_phone_event.dart';
import 'email_or_phone_state.dart';

class EmailOrPhoneBloc extends Bloc<EmailOrPhoneEvent, EmailOrPhoneState> {
  EmailOrPhoneBloc() : super(EmailOrPhoneInitialState());

  UserNetworkRepository get userNetworkRepository => _userNetworkRepository;
  UserNetworkRepository _userNetworkRepository = new UserNetworkRepository();

  UserValidatedRepository get uservalidatedRepository =>
      _uservalidatedRepository;
  UserValidatedRepository _uservalidatedRepository =
      new UserValidatedRepository();

  @override
  Stream<EmailOrPhoneState> mapEventToState(EmailOrPhoneEvent event) async* {
    if (event is EmailButtonValidationEvent) {
      yield* mapEventEmailValidateToState(event);
    }
    if (event is MobileNumButtonValidationEvent) {
      yield* mapEventMobileNumValidateToState(event);
    }

    if (event is EmailOrPhoneScreenChangeEvent) {
      yield* mapEventEmailOrPhoneScreenChangeToState(event);
    }

    if (event is UserAddEvent) {
      yield* mapEventAddUserToState(event);
    }
  }

  Stream<EmailOrPhoneState> mapEventAddUserToState(UserAddEvent event) async* {
    try {
      String? id = await userNetworkRepository.insertUserDB(event.user);
      yield UserIsAddState(id!);
    } catch (e) {
      yield UserIsNotAddState(errorMessage: e.toString());
    }
  }


  Stream<EmailOrPhoneState> mapEventEmailOrPhoneScreenChangeToState(
      EmailOrPhoneScreenChangeEvent event) async* {
    if (event.emailScreen) {
      yield EmailScreenVisibilityState();
    } else {
      yield MobileNumScreenVisibilityState();
    }
  }

  Stream<EmailOrPhoneState> mapEventEmailValidateToState(
      EmailButtonValidationEvent event) async* {
    String? email = event.user.userEmail;
    bool checkEmail = await userNetworkRepository.checkEmail(event.user);

    if (email == null || !uservalidatedRepository.isValidEmail(email)) {
      yield EmailInvalidState(message: "Enter_a_valid_email");
      return;
    }
    if (checkEmail) {
      yield EmailInvalidState(message: "such_email_already_signup");
      return;
    } else {
      yield EmailOrPhoneValidatedState(email);
    }
  }

  Stream<EmailOrPhoneState> mapEventMobileNumValidateToState(
      MobileNumButtonValidationEvent event) async* {
    String? userMobileNum = event.user.userPhoneNumber;
    bool checkuserMobileNum =
        await userNetworkRepository.checkMobilePhone(event.user);
    if (userMobileNum == null ||
        !uservalidatedRepository.isValidPhone(userMobileNum)) {
      yield MobileNumInvalidState(message: "Enter_an_mobile_number");
      return;
    }
    if (checkuserMobileNum) {
      yield MobileNumInvalidState(message: "such_phonenumber_already_signup");
      return;
    } else {
      yield EmailOrPhoneValidatedState(userMobileNum);
    }
  }
}
