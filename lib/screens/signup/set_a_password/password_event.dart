import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();
}

class PasswordButtonValidationEvent extends PasswordEvent {
  final String password;

  const PasswordButtonValidationEvent({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}
