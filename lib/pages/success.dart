import 'package:Applaudio/scoped_models/success.dart';
import 'package:flutter/material.dart';

import 'base.dart';


class SuccessView extends StatelessWidget {

  final String title;

  SuccessView({this.title});

  @override
  Widget build(BuildContext context) {
    return Base<SuccessModel>(
      onModelReady: (model) => model.fetchDuplicatedText(title),
      builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: ListView(children: <Widget>[
              Center(child:Text(model.title)),
            ]),
          ),
    );
  }
}
