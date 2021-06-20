import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading_event.dart';
import 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial());
  final UserNetworkRepository _userRepository = UserNetworkRepository();

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    if (event is UserLoadedEvent) {
      yield* mapEventValidateToState(event);
    }
  }

  Stream<LoadingState> mapEventValidateToState(UserLoadedEvent? event) async* {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.getString("token") != null) {
      var user = await _userRepository.getUser();

      yield UserLoded(user: user);
    } else
      yield UserNotLoaded();
  }
}
