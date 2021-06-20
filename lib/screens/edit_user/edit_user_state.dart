import 'package:equatable/equatable.dart';
import 'package:internship0006/screens/edit_user/edit_user_screen.dart';
import 'package:uuid/uuid.dart';

abstract class EditUserDataState extends Equatable {
  const EditUserDataState();

  @override
  List<Object> get props => [];
}

class EditUserDataInitialState extends EditUserDataState {}

class EditValidatedState extends EditUserDataState {
  final String key = Uuid().v4();
  @override
  List<Object> get props => [key];
}

class EditUserDataValidatedState extends EditUserDataState {
  final String key = Uuid().v4();
  @override
  List<Object> get props => [key];
}

class EditUserDataInvalidState extends EditUserDataState {
  final List<InputType> dataInvalid;
  final String invalidErrorMassege;
  EditUserDataInvalidState({
    required this.invalidErrorMassege,
    required this.dataInvalid,
  });
  @override
  List<Object> get props => [];
}

class FormIsFinalInvalid extends EditUserDataState {
  final String invalidErrorMassege;
  FormIsFinalInvalid({required this.invalidErrorMassege});
  @override
  List<Object> get props => [];
}

class UserIsUpdatedState extends EditUserDataState {
  @override
  List<Object> get props => [];
}

class UserIsNotUpdatedState extends EditUserDataState {
  UserIsNotUpdatedState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class InvalidFirstnameState extends EditUserDataState {
  final String message;
  InvalidFirstnameState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class InvalidLastnameState extends EditUserDataState {
  final String message;
  InvalidLastnameState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class BirthDayInvalidState extends EditUserDataState {
  final String message;
  BirthDayInvalidState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class UserNameInvalidState extends EditUserDataState {
  final String message;
  UserNameInvalidState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class PasswordInvalid extends EditUserDataState {
  final String message;
  PasswordInvalid({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class EmailInvalidState extends EditUserDataState {
  final String message;

  EmailInvalidState({required this.message});
  @override
  List<Object> get props => [message];
}

class MobileNumInvalidState extends EditUserDataState {
  final String message;

  MobileNumInvalidState({required this.message});
  @override
  List<Object> get props => [message];
}
