
import 'package:equatable/equatable.dart';
import 'package:internship0006/model/user.dart';

abstract class AllUserState extends Equatable {
  const AllUserState();

  @override
  List<Object> get props => [];
}


class AllUserInitialState extends AllUserState {}

class AllUsersState extends AllUserState {
  final List<User> users;
  AllUsersState({required this.users});

  @override
  List<Object> get props => [users];
}
