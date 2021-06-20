import 'package:equatable/equatable.dart';
import 'package:internship0006/model/user.dart';
import 'package:uuid/uuid.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();
}

class LoadingInitial extends LoadingState {
  @override
  List<Object> get props => [];
}

class UserLoded extends LoadingState {
  const UserLoded({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class UserNotLoaded extends LoadingState {
  final String key = Uuid().v4();
  @override
  List<Object> get props => [key];
}
