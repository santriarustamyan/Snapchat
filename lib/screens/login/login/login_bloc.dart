import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/login/login/login_event.dart';
import 'package:internship0006/screens/login/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  User? get user => _user;
  User? _user;

  UserNetworkRepository get userNetworkRepository => _userNetworkRepository;
  UserNetworkRepository _userNetworkRepository = UserNetworkRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonValidationEvevt) {
      yield* mapEventValidateToState(event);
    }

    if (event is UserLoginEvent) {
      yield* mapEventIdentificationToState(event);
    }
  }

  Stream<LoginState> mapEventValidateToState(
      LoginButtonValidationEvevt? event) async* {
    String? loginname = event?.nameforlogin;
    String? password = event?.password;

    if (loginname == null || loginname.length < 1) {
      yield InvalidPassword();
    } else if (password == null || password.length < 8) {
      yield InvalidLoginName();
    } else {
      yield LoginPasswordValidated(loginname, password);
    }
  }

  Stream<LoginState> mapEventIdentificationToState(
      UserLoginEvent event) async* {
    try {
      _user = await userNetworkRepository.login(
          event.identificator, event.password);

      yield UserSuccessState();
    } catch (e) {
      yield UserFalseState(errorMessage: e.toString());
    }

    yield LoginInitial();
  }
}
