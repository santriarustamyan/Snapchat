import 'package:equatable/equatable.dart';

abstract class FullNameState extends Equatable {
  const FullNameState();

  @override
  List<Object> get props => [];
}

class FullNameInitialState extends FullNameState {}

class InvalidFirstnameState extends FullNameState {

final String message;
InvalidFirstnameState({required this.message,});
  @override
  List<Object> get props => [message];
  
}

class InvalidLastnameState extends FullNameState {
final String message;
InvalidLastnameState({required this.message,});
  @override
  List<Object> get props => [message];
  
}

class FullNameValidatedState extends FullNameState {
  final String firstName;
  final String lastName;

  FullNameValidatedState(this.firstName, this.lastName);
  @override
  List<Object> get props => [firstName, lastName];
}
