import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:internship0006/class/user_validated_repository.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/edit_user/edit_user_event.dart';
import 'package:internship0006/screens/edit_user/edit_user_state.dart';
import 'package:internship0006/screens/edit_user/edit_user_screen.dart';

class EditUserDataBloc extends Bloc<EditUserDataEvent, EditUserDataState> {
  EditUserDataBloc() : super(EditUserDataInitialState());

  UserNetworkRepository get userNetworkRepository => _userNetworkRepository;
  UserNetworkRepository _userNetworkRepository = new UserNetworkRepository();

  UserValidatedRepository get uservalidatedRepository =>
      _uservalidatedRepository;
  UserValidatedRepository _uservalidatedRepository =
      new UserValidatedRepository();

  User? get user => _user;
  User? _user;

  @override
  Stream<EditUserDataState> mapEventToState(EditUserDataEvent event) async* {
    if (event is ValidationEvent) {
      yield* mapEventValidateToState(event);
    }
    if (event is OKButtonValidationEvent) {
      yield* mapEventOKButtonValidateToState(event);
    }
    if (event is UserEditEvent) {
      yield* mapEventUserEditValidateToState(event);
    }
  }

  Stream<EditUserDataState> mapEventUserEditValidateToState(
      UserEditEvent event) async* {
    try {
      await userNetworkRepository.updateUsers(
        event.user,
      );
      yield UserIsUpdatedState();
    } catch (e) {
      yield UserIsNotUpdatedState(errorMessage: e.toString());
    }
  }

  Stream<EditUserDataState> mapEventValidateToState(
      ValidationEvent event) async* {
    InputType inputType = event.inputType;
    String val = event.value;

    switch (inputType) {
      case InputType.firstName:
        if (!uservalidatedRepository.isValidFirstname(val)) {
          yield InvalidFirstnameState(message: "Enter_a_first_name");
        } else
          yield EditValidatedState();
        break;

      case InputType.lastName:
        if (!uservalidatedRepository.isValidLastname(val))
          yield InvalidLastnameState(message: "Enter_a_last_name");
        else
          yield EditValidatedState();
        break;

      case InputType.birthDay:
        if (!uservalidatedRepository.isvalidData(val)) {
          yield BirthDayInvalidState(message: "Enter_Birth_Date");
        } else
          yield EditValidatedState();
        break;

      case InputType.userName:
        if (!uservalidatedRepository.isValidUsername(val))
          yield UserNameInvalidState(message: "Enter_a_username");
        else if (event.copyUser!.username !=
            event
                .originalUser.username) if (await userNetworkRepository
            .checkUsername(event.copyUser!))
          yield UserNameInvalidState(message: "such_username_already_signup");
        else
          yield EditValidatedState();
        break;

      case InputType.password:
        if (!uservalidatedRepository.isValidPassword(val)) {
          yield PasswordInvalid(message: "Enter_a_password");
        } else
          yield EditValidatedState();
        break;

      case InputType.email:
        if (!uservalidatedRepository.isValidEmail(val))
          yield EmailInvalidState(message: "Enter_a_valid_email");
        else if (event.copyUser!.userEmail !=
            event
                .originalUser.userEmail) if (await userNetworkRepository
            .checkEmail(event.copyUser!))
          yield EmailInvalidState(message: "such_email_already_signup");
        else
          yield EditValidatedState();
        break;

      case InputType.mobNumber:
        if (!uservalidatedRepository.isValidPhone(val))
          yield MobileNumInvalidState(message: "Enter_an_mobile_number");
        else if (event.copyUser!.userPhoneNumber !=
            event
                .originalUser.userPhoneNumber) if (await userNetworkRepository
            .checkMobilePhone(event.copyUser!))
          yield MobileNumInvalidState(
              message: "such_phonenumber_already_signup");
        else
          yield EditValidatedState();
        break;
    }
  }

  Stream<EditUserDataState> mapEventOKButtonValidateToState(
      OKButtonValidationEvent event) async* {
    bool isFromValid = true;
    bool isPhoneValid = true;
    bool isEmailValid = true;
    String invalIderrorMassege = "";

    if (event.copyUser.userEmail == "" ||
        !uservalidatedRepository.isValidEmail(event.copyUser.userEmail!)) {
      isEmailValid = false;
      invalIderrorMassege = "Enter_a_valid_email";
      yield EmailInvalidState(message: "Enter_a_valid_email");
    } else if (event.copyUser.userEmail != event.originalUser.userEmail) {
      if (await userNetworkRepository.checkEmail(event.copyUser)) {
        invalIderrorMassege = "such_email_already_signup";
        isEmailValid = false;
        yield EmailInvalidState(message: "such_email_already_signup");
      }
    }

    if (event.copyUser.userPhoneNumber == "" ||
        !uservalidatedRepository
            .isValidPhone(event.copyUser.userPhoneNumber!)) {
      invalIderrorMassege = "Enter_an_mobile_number";
      isPhoneValid = false;
      yield MobileNumInvalidState(message: "Enter_an_mobile_number");
    } else if (event.copyUser.userPhoneNumber !=
        event.originalUser.userPhoneNumber) {
      if (await userNetworkRepository.checkMobilePhone(event.copyUser)) {
        invalIderrorMassege = "such_phonenumber_already_signup";
        isPhoneValid = false;
        yield MobileNumInvalidState(message: "such_phonenumber_already_signup");
      }
    }

    if (event.copyUser.userFirstname == null ||
        !uservalidatedRepository
            .isValidFirstname(event.copyUser.userFirstname)) {
      invalIderrorMassege = "Enter_a_first_name";
      isFromValid = false;

      yield InvalidFirstnameState(message: "Enter_a_first_name");
    }

    if (event.copyUser.userLastname == null ||
        !uservalidatedRepository.isValidLastname(event.copyUser.userLastname)) {
      invalIderrorMassege = "Enter_a_last_name";
      isFromValid = false;
      yield InvalidLastnameState(message: "Enter_a_last_name");
    }

    if (event.copyUser.userBirthday == null ||
        !uservalidatedRepository.isvalidData(event.copyUser.userBirthday!)) {
      invalIderrorMassege = "Enter_Birth_Date";
      isFromValid = false;
      yield BirthDayInvalidState(message: "Enter_Birth_Date");
    }

    if (event.copyUser.username == null ||
        !uservalidatedRepository.isValidUsername(event.copyUser.username)) {
      invalIderrorMassege = "Enter_a_username";
      isFromValid = false;
      yield UserNameInvalidState(message: "Enter_a_username");
    }

    if (event.copyUser.username != event.originalUser.username) {
      if (event.copyUser.username == null ||
          await userNetworkRepository.checkUsername(event.copyUser)) {
        invalIderrorMassege = "such_username_already_signup";
        isFromValid = false;
        yield UserNameInvalidState(message: "such_username_already_signup");
      }
    }

    if (event.copyUser.userPassword == null ||
        !uservalidatedRepository.isValidPassword(event.copyUser.userPassword)) {
      invalIderrorMassege = "Enter_a_password";
      isFromValid = false;
      yield PasswordInvalid(message: "Enter_a_password");
    }

    if (event.copyUser.userPhoneNumber != "" &&
        isPhoneValid == false &&
        event.copyUser.userPhoneNumber!.isNotEmpty) {
      isFromValid = false;
    }
    if (event.copyUser.userEmail != "" &&
        isEmailValid == false &&
        event.copyUser.userEmail!.isNotEmpty) {
      isFromValid = false;
    }

    if (isEmailValid == false && isPhoneValid == false) {
      isFromValid = false;
    }

    if (isFromValid == false) {
      yield FormIsFinalInvalid(invalidErrorMassege: invalIderrorMassege);
    } else
      yield EditUserDataValidatedState();
  }
}
