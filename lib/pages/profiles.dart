//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

//widgets
import '../widgets/profiles/profiles.dart';

class ProfilesPage extends StatelessWidget {
  Widget _buildFloatingActionButton(
      BuildContext context, Function setSelectedProfile) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xFFB4C42D),
      onPressed: () {
        setSelectedProfile(null);
        Navigator.pushNamed(context, 'edit');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              }, 
            ),
            title: Text('Profielen'),
            actions: <Widget>[
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
          body: Profiles(),
          floatingActionButton:
              _buildFloatingActionButton(context, model.selectProfile),
        );
      },
    );
  }
}
