import 'package:equatable/equatable.dart';
import 'package:internship0006/model/user.dart';

abstract class UserNameEvent extends Equatable {
  const UserNameEvent();
}

class UserNameButtonValidationEvent extends UserNameEvent {
  final User user;

  const UserNameButtonValidationEvent({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UserNameExistsEvent extends UserNameEvent {
  final String userName;

  const UserNameExistsEvent({required this.userName});

  @override
  List<Object> get props => [userName];
}
