import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitialState extends PasswordState {}

class PasswordInvalidState extends PasswordState {

final String message;
PasswordInvalidState({required this.message,});
  @override
  List<Object> get props => [message];


}

class PasswordValidatedState extends PasswordState {
  final String password;

  PasswordValidatedState(this.password);

  @override
  List<Object> get props => [password];
}
