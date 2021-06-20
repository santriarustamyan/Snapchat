import 'package:flutter/cupertino.dart';
import 'package:internship0006/class/app_localizations.dart';

extension Localizations on String {
  String localizations(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
