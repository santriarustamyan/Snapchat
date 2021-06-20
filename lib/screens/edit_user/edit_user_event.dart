import 'package:equatable/equatable.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/edit_user/edit_user_screen.dart';

abstract class EditUserDataEvent extends Equatable {
  const EditUserDataEvent();
}

class OKButtonValidationEvent extends EditUserDataEvent {
  final User copyUser;
  final User originalUser;
  const OKButtonValidationEvent(
      {required this.originalUser, required this.copyUser});

  @override
  List<Object> get props => [];
}

class ValidationEvent extends EditUserDataEvent {
  final InputType inputType;
  final String value;
  final User? copyUser;
  final User originalUser;
  const ValidationEvent({
    required this.inputType,
    required this.value,
    required this.copyUser,
    required this.originalUser,
  });

  @override
  List<Object> get props => [inputType];
}

class UserEditEvent extends EditUserDataEvent {
  final User user;
  const UserEditEvent({required this.user});

  @override
  List<Object> get props => [];
}
