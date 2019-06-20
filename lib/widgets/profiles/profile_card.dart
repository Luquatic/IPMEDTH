//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';
import '../../models/profile.dart';

//pages
import '../../pages/profile_edit.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final int profileIndex;

  ProfileCard(this.profile, this.profileIndex);

  Widget _buildCloseButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () {
                model.selectProfile(profileIndex);
                model.deleteProfile();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleContainer() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            profile.title,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            // Edit profile
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                model.selectProfile(profileIndex);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProfileEditPage();
                    },
                  ),
                );
              },
            ),
            //Favorite profile
            IconButton(
              icon: Icon(model.profiles[profileIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProfile(profileIndex);
                model.toggleProfileFavoriteStatus();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildCloseButton(),
          _buildTitleContainer(),
          Text('Volume: ' + profile.volume.toStringAsFixed(2)),
          _buildButtonBar(context),
        ],
      ),
    );
  }
}
