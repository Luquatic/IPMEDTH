//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

//pages
import './profile_edit.dart';

class ProfileListPage extends StatelessWidget {
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

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) =>
        Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Profielen'),
          ),
          body: ListView.builder(
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
                      title:Text(model.profiles[index].title.length != 0 ? model.profiles[index].title : 'Nog geen profielen aangemaakt.'),
                      trailing: _buildEditButton(context, index, model),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Color(0xFFB4C42D),
              onPressed: () {
                // Navigator.of(context).pop(MaterialPageRoute(
                //   builder: (BuildContext context) {
                //     return ProfileEditPage();
                //   },
                // ),);
              }),
        ),
    );
  }
}
