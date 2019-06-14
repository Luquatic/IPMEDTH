import 'dart:async';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../models/profile.dart';
import '../scoped_models/profiles.dart';

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
    }, child: ScopedModelDescendant<ProfilesModel>(
      builder: (BuildContext context, Widget child, ProfilesModel model) {
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
