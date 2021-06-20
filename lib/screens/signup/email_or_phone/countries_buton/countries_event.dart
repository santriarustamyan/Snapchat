import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class GetCountryEvent extends CountryEvent {
  @override
  List<Object> get props => [];
}

class ChangeCountryEvent extends CountryEvent {
  ChangeCountryEvent(this.searchName);

  final String searchName;

  @override
  List<Object> get props => [];
}
