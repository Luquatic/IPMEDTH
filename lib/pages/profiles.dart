//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../models/profile.dart';
import '../scoped_models/main.dart';

//widgets
import '../widgets/profiles/profiles.dart';
import '../widgets/profiles/profile_card.dart';
import '../widgets/profiles/profiles_list.dart';

class ProfilesPage extends StatelessWidget {
  Widget _buildFloatingActionButton(BuildContext context, int index) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                color: Colors.white,
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: Profiles(),
      floatingActionButton: _buildFloatingActionButton(context, 0),
    );
  }
}
