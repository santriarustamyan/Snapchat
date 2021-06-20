import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:internship0006/classes/localizations.dart';

class HtemText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Html(
          data: """<div>  
<span style="color:rgb(53, 56, 62);">${"By_Sign_Up_&_Accept_acknowledge".localizations(context)}</span><span style="color:rgb(47, 168, 255);">${"Privacy_Policy".localizations(context)}</span><span style="color:rgb(53, 56, 62);">${"and_agree_to_the".localizations(context)}</span><span style="color:rgb(47, 168, 255);">${"Terms_of_Service".localizations(context)}</span>
</div>""",
        ));
  }
}
