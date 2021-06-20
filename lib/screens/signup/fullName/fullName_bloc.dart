import 'package:bloc/bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/signup/fullName/fullName_event.dart';
import 'package:internship0006/screens/signup/fullName/fullName_state.dart';

class FullNameBloc extends Bloc<FullNameEvent, FullNameState> {
  FullNameBloc() : super(FullNameInitialState()) {
    _user = User();
  }

  User? get user => _user;
  User? _user;

  @override
  Stream<FullNameState> mapEventToState(FullNameEvent event) async* {
    if (event is FullNameButtonValidationEvevt) {
      yield* mapEventValidateToState(event);
    }
  }

  Stream<FullNameState> mapEventValidateToState(
      FullNameButtonValidationEvevt? event) async* {
    String? firstName = event?.firstName;
    String? lastName = event?.lastName;

    if (lastName == null || lastName.length<1) {
      yield InvalidLastnameState(message:"Enter_a_last_name");
    } else if (firstName == null || firstName.length<1) {
      yield InvalidFirstnameState(message:"Enter_a_first_name");
    } else {
      yield FullNameValidatedState(firstName, lastName);
    }
  }
  
}
