import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/screens/signup/set_a_password/password_event.dart';
import 'package:internship0006/screens/signup/set_a_password/password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitialState());

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is PasswordButtonValidationEvent) {
      yield* mapEventValidateToState(event);
    }
  }

  Stream<PasswordState> mapEventValidateToState(
      PasswordButtonValidationEvent? event) async* {
    String? password = event?.password;

    if (password == null || password.length < 8) {
      yield PasswordInvalidState(message:"Enter_a_password");
    } else {
      yield PasswordValidatedState(password);
    }
  }
}
