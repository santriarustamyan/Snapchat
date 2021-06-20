import 'package:equatable/equatable.dart';
import 'package:internship0006/model/country.dart';
import 'package:uuid/uuid.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitialState extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoadingState extends CountryState {
  final String key = Uuid().v4();
  @override
  List<Object> get props => [key];
}

class CountryLoadedState extends CountryState {
  final List<Country> country;

  CountryLoadedState({required this.country});

  @override
  List<Object> get props => [country];
}

class CountryChangesState extends CountryState {
  CountryChangesState(this.chancountry);
  final String key = Uuid().v4();
  final List<Country> chancountry;

  @override
  List<Object> get props => [chancountry];
}
