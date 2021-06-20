import 'package:bloc/bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_event.dart';
import 'package:internship0006/screens/signup/pick_a_username/username_state.dart';

class UserNameBloc extends Bloc<UserNameEvent, UserNameState> {
  UserNameBloc() : super(UserNameInitialState());

  UserNetworkRepository get userNetworkRepository => _userNetworkRepository;
  UserNetworkRepository _userNetworkRepository = new UserNetworkRepository();

  @override
  Stream<UserNameState> mapEventToState(UserNameEvent event) async* {
    if (event is UserNameButtonValidationEvent) {
      yield* mapEventValidateToState(event);
    }
  }

  Stream<UserNameState> mapEventValidateToState(
      UserNameButtonValidationEvent? event) async* {
    String? userName = event?.user.username;

    bool checkuserName = await userNetworkRepository.checkUsername(event!.user);

    if (userName == null || userName.length < 5) {
      yield UserNameInvalidState(message: "Enter_a_username");
      return;
    }
    if (checkuserName) {
      yield UserNameInvalidState(message: "such_username_already_signup");
      return;
    } else {
      yield UserNameValidatedState(userName);
    }
  }
}
