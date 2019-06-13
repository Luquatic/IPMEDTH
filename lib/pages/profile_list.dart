import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../models/profile.dart';
import '../scoped_models/profiles.dart';

import './profile_edit.dart';

class ProfileList extends StatefulWidget {
  @override
  _Profiles createState() => _Profiles();
}

class _Profiles extends State<ProfileList> {
  String _profileName = '';
  double _value = 0.0;

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Profielen'),
            onTap: () {
              Navigator.pushNamed(context, '/profiles');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfilesListView(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        background: _onDismissedBackground(),
        key: Key('K E Y'),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            //delete profile
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Profielen'),
              trailing: _buildEditButton(context, index),
            ),
            Divider(),
          ],
        ),
      );
    });
  }

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

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return ProductEditPage(
        //         product: products[index],
        //         updateProduct: updateProduct,
        //         productIndex: index,
        //       );
        //     },
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>(
      builder: (BuildContext context, Widget child, ProfilesModel model) {
        Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text(''),
          ),
          body: _buildProfilesListView(context),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Color(0xFFB4C42D),
              onPressed: () {
                Navigator.of(context).pop(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProfileEditPage();
                  },
                ));
              }),
        );
      },
    );
  }
}
