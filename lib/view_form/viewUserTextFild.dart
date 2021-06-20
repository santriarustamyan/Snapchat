import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:internship0006/widgets/txt_field.dart';

class ViewUsers extends StatelessWidget {
  final String? head;
  final String? vali;
  final Function(String)? onChange;
  ViewUsers({
    this.onChange,
    this.head,
    this.vali,
  });

  @override
  Widget build(BuildContext context) {
   
     return TxtFieldForScreen(  
       onChange: onChange,    
      label: head,
      obscure: false,
      initialValue: vali,
    );
  }

  
  }
