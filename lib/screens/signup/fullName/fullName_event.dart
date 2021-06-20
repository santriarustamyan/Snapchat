import 'package:equatable/equatable.dart';
abstract class FullNameEvent extends Equatable {
  const FullNameEvent();
}

class FullNameButtonValidationEvevt extends FullNameEvent {
  final String firstName;
  final String lastName;

  const FullNameButtonValidationEvevt(
      {required this.firstName, required this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}
