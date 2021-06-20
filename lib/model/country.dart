class Country {
  String? e164cc;
  String? iso2cc;
  String? name;
  String? example;
  String? displayName;
  String? fullExampleWithPlusSign;
  String? displayNameNoE164cc;
  String? e164Key;

  Country({
    this.e164cc,
    this.iso2cc,
    this.name,
    this.example,
    this.displayName,
    this.fullExampleWithPlusSign,
    this.displayNameNoE164cc,
    this.e164Key,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
      e164cc: json["e164_cc"] as String,
      iso2cc: json["iso2_cc"] as String,
      name: json["name"] as String,
      example: json["example"] as String,
      displayName: json["display_name"] as String,
      fullExampleWithPlusSign: json["full_example_with_plus_sign"] as String,
      displayNameNoE164cc: json["display_name_no_e164_cc"] as String,
      e164Key: json["e164_key"] as String,
    );
  }
}
