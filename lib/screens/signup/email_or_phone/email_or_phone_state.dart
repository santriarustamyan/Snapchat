import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class EmailOrPhoneState extends Equatable {
  const EmailOrPhoneState();

  @override
  List<Object> get props => [];
}

class EmailOrPhoneInitialState extends EmailOrPhoneState {}

class EmailOrPhoneValidatedState extends EmailOrPhoneState {
  final String emailOrPhone;

  EmailOrPhoneValidatedState(this.emailOrPhone);

  @override
  List<Object> get props => [emailOrPhone];
}

class EmailInvalidState extends EmailOrPhoneState {
  final String message;

  EmailInvalidState({required this.message});
  @override
  List<Object> get props => [message];
}

class MobileNumInvalidState extends EmailOrPhoneState {
  final String message;

  MobileNumInvalidState({required this.message});
  @override
  List<Object> get props => [message];
}

class MobileNumScreenVisibilityState extends EmailOrPhoneState {
  @override
  List<Object> get props => [];
}

class EmailScreenVisibilityState extends EmailOrPhoneState {
  @override
  List<Object> get props => [];
}

class UserIsAddState extends EmailOrPhoneState {
  final String key = Uuid().v4();
  final String id;
  UserIsAddState(this.id);
  @override
  List<Object> get props => [key];
}

class UserIsNotAddState extends EmailOrPhoneState {
  UserIsNotAddState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
