import 'package:equatable/equatable.dart';
import 'package:internship0006/model/user.dart';

abstract class EmailOrPhoneEvent extends Equatable {
  const EmailOrPhoneEvent();
}

class EmailButtonValidationEvent extends EmailOrPhoneEvent {
  final User user;

  const EmailButtonValidationEvent({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UserAddEvent extends EmailOrPhoneEvent {
  final User user;

  const UserAddEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class EmailExistsEvent extends EmailOrPhoneEvent {
  final String email;

  const EmailExistsEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class MobileNumButtonValidationEvent extends EmailOrPhoneEvent {
  final User user;

  const MobileNumButtonValidationEvent({required this.user});

  @override
  List<Object> get props => [
        user,
      ];
}

class MobileNumExistsEvent extends EmailOrPhoneEvent {
  final String mobileNum;

  const MobileNumExistsEvent({required this.mobileNum});

  @override
  List<Object> get props => [mobileNum];
}

class EmailOrPhoneScreenChangeEvent extends EmailOrPhoneEvent {
  final bool emailScreen;

  const EmailOrPhoneScreenChangeEvent({required this.emailScreen});

  @override
  List<Object> get props => [emailScreen];
}
