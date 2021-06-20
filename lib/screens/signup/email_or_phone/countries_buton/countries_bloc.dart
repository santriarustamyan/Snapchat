import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/class/country_network_repository.dart';
import 'package:internship0006/model/country.dart';

import 'countries_event.dart';
import 'countries_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitialState()) {
    _countryRepository = CountryNetworkRepository();
    _country = [];
  }

  List<Country> get country => _country;
  late List<Country> _country;
  late CountryNetworkRepository _countryRepository;

  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async* {
    if (event is GetCountryEvent) {
      yield* mapEventGetCountryToState(event);
    }
    if (event is ChangeCountryEvent) {
      yield* mapEventChangeCountryToState(event);
    }
  }

  Stream<CountryState> mapEventChangeCountryToState(
      ChangeCountryEvent event) async* {
    List<Country> changeCountry = [];
    changeCountry = _countryRepository.filterSearchResults(event.searchName);
    yield CountryChangesState(changeCountry);
  }

  Stream<CountryState> mapEventGetCountryToState(GetCountryEvent event) async* {
    yield CountryLoadingState();

    _country = await _countryRepository.loadCountry();

    yield CountryLoadedState(country: _country);
  }
}
