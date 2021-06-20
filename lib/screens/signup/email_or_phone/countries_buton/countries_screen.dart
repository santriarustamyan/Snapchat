import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/classes/loading_country.dart';
import 'package:internship0006/model/country.dart';
import 'countries_bloc.dart';
import 'extensionFlag.dart';
import 'countries_event.dart';
import 'countries_state.dart';
import 'package:internship0006/classes/localizations.dart';


class CountryScreen extends StatefulWidget {
  CountryScreen({
    this.countryNotifier,
  });
  final ValueNotifier<Country>? countryNotifier;

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late CountryBloc _countryBloc;
  List<Country> _country = [];
  final duplicateItems = List<String>.generate(1000, (i) => "Item $i");
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _countryBloc = CountryBloc();
    _countryBloc.add(GetCountryEvent());
  }

  @override
  void dispose() {
    _countryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryBloc>(
        create: (context) {
          return _countryBloc;
        },
        child: BlocListener<CountryBloc, CountryState>(
          listener: _blocListner,
          child: _render(),
        ));
  }

  Widget _render() {
    return BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (val) {
                    _countryBloc.add(ChangeCountryEvent(val));
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Search".localizations(context),
                      hintText: "Search".localizations(context),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black,
                      child: SizedBox(
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            _toPhonePageAction(state, index, context);
                          },
                          child: _callbackCountry(index),
                        ),
                      ),
                      shape: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    );
                  },
                  itemCount: _country.length,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _callbackCountry(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${(_country[index].iso2cc)!.calculateFlag()} ${_country[index].name}",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _country[index].e164cc!,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _blocListner(context, state) {
    if (state is CountryLoadedState) {
      Navigator.pop(context);
      _country = _countryBloc.country;
    }
    if (state is CountryChangesState) {
      _country = state.chancountry;
    }

    if (state is CountryLoadingState) {
      IconLoadCountry.showLoading(context);
    }
  }

  void _toPhonePageAction(state, index, context) {
    widget.countryNotifier!.value = _country[index];

    Navigator.pop(context);
  }
}
