/*
  this page is used to display the profiles
*/

//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

//widgets
import '../widgets/profiles/profiles.dart';

class ProfilesPage extends StatelessWidget {
  // build floatingactionbutton to add profiles
  Widget _buildFloatingActionButton(
      BuildContext context, Function setSelectedProfile) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFB4C42D),
      onPressed: () {
        setSelectedProfile(null);
        // Note: the page for add and edit is the same, so edit links to add as well as edit
        Navigator.pushNamed(context, 'edit');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // build with the model
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // WillPopScope alters the behaviour of the Android back button
        return WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // return by header arrow_back
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              title: Text('Profielen'),
              actions: <Widget>[
                // display right icon based on favorite items
                IconButton(
                  color: Colors.white,
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                ),
              ],
            ),
            //display the Profiles widget and the floatingactionbutton
            body: Profiles(),
            floatingActionButton:
                _buildFloatingActionButton(context, model.selectProfile),
          ),
        );
      },
    );
  }
}
