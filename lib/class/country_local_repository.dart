import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb_realm/database/mongo_document.dart';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:internship0006/model/country.dart';

class CountryLocalRepository {
  CountryLocalRepository() {
    _countries = [];
  }
  final MongoRealmClient client = MongoRealmClient();

  late Country country;

  late List<Country> _countries;

  List<Country> get dataCountry => _countries;

  Future<String> _loadACountryAsset() async {
    return await rootBundle.loadString('assets/country-codes.json');
  }

  Future<List<Country>> loadCountry() async {
    String jsonString = await _loadACountryAsset();
    List<dynamic> data = json.decode(jsonString);
    var _collection = client.getDatabase("snapchat").getCollection("country");

 List<MongoDocument> checkUsername = await _collection.find();

    var quantity = checkUsername.length;
    
    if (quantity == 0) {
      data.forEach((element) {
        country = Country.fromJson(element);

        _insertCountry(country);
      });
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
    var collection = client.getDatabase("snapchat").getCollection("country");

    var docs = await collection.find();
   

    docs.forEach((element) {
      Country _country =  Country();

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
      return List<Country>.from(_countries.where(
          (item) => item.name!.toLowerCase().contains(query.toLowerCase())));
    } else {
      return _countries;
    }
  }
}
