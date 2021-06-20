import 'package:equatable/equatable.dart';

abstract class UserNameState extends Equatable {
  const UserNameState();

  @override
  List<Object> get props => [];
}

class UserNameInitialState extends UserNameState {}

class UserNameInvalidState extends UserNameState {

final String message;
UserNameInvalidState({required this.message,});
  @override
  List<Object> get props => [message];
}

class UserNameValidatedState extends UserNameState {
  final String userName;

  UserNameValidatedState(this.userName);

  @override
  List<Object> get props => [userName];
}

