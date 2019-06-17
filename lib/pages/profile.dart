//libraries
import 'dart:async';
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import '../models/profile.dart';

class ProfilePage extends StatelessWidget {
  final int profileIndex;

  ProfilePage(this.profileIndex);

  Widget _buildTitleContainer(String title) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('text'),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Profile product = model.profiles[profileIndex];
        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Text('center')
        );
      },
    ));
  }
}
