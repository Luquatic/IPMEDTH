import 'package:Applaudio/scoped_models/error_model.dart';
import 'package:flutter/material.dart';

import 'base.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Base<ErrorModel>(
      builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: ListView(children: <Widget>[
              Center(child:Text(this.runtimeType.toString())),
            ]),
          ),
    );
  }
}
