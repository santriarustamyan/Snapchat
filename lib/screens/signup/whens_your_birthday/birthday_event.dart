import 'package:equatable/equatable.dart';

abstract class BirthDayEvent extends Equatable {
  const BirthDayEvent();
}

class BirthDayButtonValidationEvent extends BirthDayEvent {
  final String userBirthDay;

  const BirthDayButtonValidationEvent({
    required this.userBirthDay,
  });

  @override
  List<Object> get props => [
        userBirthDay,
      ];
}
