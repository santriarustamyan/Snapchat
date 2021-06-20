import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/user_network_repository.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/all_users/all_users_state.dart';

class AllUserCubit extends Cubit<AllUserState> {
  AllUserCubit() : super(AllUserInitialState());

  UserNetworkRepository get userNetworkRepository => _userNetworkRepository;
  UserNetworkRepository _userNetworkRepository = UserNetworkRepository();

  Future<void> getAllUser() async {
    final List<User> _users = await userNetworkRepository.getUsers();

    emit(AllUsersState(users: _users));
  }
}
