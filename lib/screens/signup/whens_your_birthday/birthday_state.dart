import 'package:equatable/equatable.dart';

abstract class BirthDayState extends Equatable {
  const BirthDayState();

  @override
  List<Object> get props => [];
}

class BirthDayInitialState extends BirthDayState {}

class BirthDayInvalidState extends BirthDayState {
final String message;
BirthDayInvalidState({required this.message,});
  @override
  List<Object> get props => [message];

}



class BirthDayValidatedState extends BirthDayState {
  final String userBirthDay;

  BirthDayValidatedState(this.userBirthDay);

  @override
  List<Object> get props => [userBirthDay];
}
