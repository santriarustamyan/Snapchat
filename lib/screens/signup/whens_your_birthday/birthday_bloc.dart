import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/user_validated_repository.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_event.dart';
import 'package:internship0006/screens/signup/whens_your_birthday/birthday_state.dart';

class BirthDayBloc extends Bloc<BirthDayEvent, BirthDayState> {
  BirthDayBloc() : super(BirthDayInitialState());

  UserValidatedRepository get uservalidatedRepository =>
      _uservalidatedRepository;
  UserValidatedRepository _uservalidatedRepository =
      new UserValidatedRepository();

  @override
  Stream<BirthDayState> mapEventToState(BirthDayEvent event) async* {
    if (event is BirthDayButtonValidationEvent) {
      yield* mapEventValidateToState(event);
    }
  }

  Stream<BirthDayState> mapEventValidateToState(
      BirthDayButtonValidationEvent? event) async* {
    String? userBirthDay = event?.userBirthDay;

    if (userBirthDay == null ||
        !uservalidatedRepository.isvalidData(userBirthDay)) {
      yield BirthDayInvalidState(message: "Enter_Birth_Date");
    } else {
      yield BirthDayValidatedState(userBirthDay);
    }
  }
}
