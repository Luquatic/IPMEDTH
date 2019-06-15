import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../models/profile.dart';
import '../../scoped_models/profiles.dart';

import '../../pages/profile_edit.dart';

class ProfilesList extends StatelessWidget {
  Widget _onDismissedBackground() {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.only(right: 20.0),
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEditButton(BuildContext context, int index, ProfilesModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProfile(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProfileEditPage();
            },
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFB4C42D),
      onPressed: () {
        Navigator.popAndPushNamed(context, 'edit');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>(
        builder: (BuildContext context, Widget child, ProfilesModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: _onDismissedBackground(),
            key: Key(model.profiles[index].title),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProfile(index);
                model.deleteProfile();
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(model.profiles[index].title),
                  trailing: _buildEditButton(context, index, model),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.profiles.length,
      );
    });
  }
}
