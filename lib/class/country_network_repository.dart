import 'dart:convert';
import 'dart:async';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:internship0006/model/country.dart';
import 'package:http/http.dart' as http;

class CountryNetworkRepository {
  CountryNetworkRepository() {
    _countries = [];
  }

  late Country country;
  final MongoRealmClient client = MongoRealmClient();
  late List<Country> _countries;

  List<Country> _loadACountryAsset(String responsebody) {
    var list = json.decode(responsebody) as List<dynamic>;
    _countries = list.map((model) => Country.fromJson(model)).toList();
    return _countries;
  }

  Future<List<Country>> loadCountry() async {
    var url = Uri.parse(
        'https://drive.google.com/uc?id=1SuvADk8EeyXU0vjQ159W9Kuxw4Mi_dGA&exprt=download');

    var _collection = client.getDatabase("snapchat").getCollection("country");

    List<MongoDocument> checkUsername = await _collection.find();

    var quantity = checkUsername.length;

    if (quantity == 0) {
      final response =
          await http.get(url, headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        _loadACountryAsset(response.body).forEach((element) {
          _insertCountry(element);
        });
      } else {
        throw Exception("Request API Error");
      }
    }
    return _getCountries();
  }

  Future<void> _insertCountry(Country country) async {
    var _collection = client.getDatabase("snapchat").getCollection("country");

    _collection.insertOne(MongoDocument({
      "e164_cc": country.e164cc,
      "iso2_cc": country.iso2cc,
      "name": country.name,
      "example": country.example,
      "display_name": country.displayName,
      "full_example_with_plus_sign": country.fullExampleWithPlusSign,
      "display_name_no_e164_cc": country.displayNameNoE164cc,
      "e164_key": country.e164Key,
    }));
  }

  Future<List<Country>> _getCountries() async {
    var _collection = client.getDatabase("snapchat").getCollection("country");

    var docs = await _collection.find();

    docs.forEach((element) {
      Country _country = Country();

      _country.e164cc = element.get("e164_cc");
      _country.iso2cc = element.get("iso2_cc");
      _country.name = element.get("name");
      _country.example = element.get("example");
      _country.displayName = element.get("display_name");
      _country.fullExampleWithPlusSign =
          element.get("full_example_with_plus_sign");
      _country.displayNameNoE164cc = element.get("display_name_no_e164_cc");
      _country.e164Key = element.get("e164_key");
      _countries.add(_country);
    });

    return _countries;
  }

  List<Country> filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Country> dummyListData = [];
      _countries.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      return dummyListData;
    } else {
      return _countries;
    }
  }
}
