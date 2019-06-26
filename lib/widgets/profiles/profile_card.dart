/*
  this widget builds the card to display a profile on the profiles page
*/

//libraries
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';
import '../../models/profile.dart';

//pages
import '../../pages/profile_edit.dart';

class ProfileCard extends StatelessWidget {
  // initialize the profile
  final Profile profile;
  final int profileIndex;

  ProfileCard(this.profile, this.profileIndex);

  // close button to delete a profile
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
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profiel verwijderd'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
  // display the profile title
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
  // display the icons for favorite and edit
  Widget _buildIconBar(BuildContext context) {
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

  // button to make profile active from profile page
  Widget _buildIsActiveButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // check if profile is active
        if (model.profiles[profileIndex].isActive) {
          return Center(
            child: OutlineButton(
              color: Colors.white,
              borderSide:
                  BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
              child: (Text(
                'Actief',
                style: TextStyle(color: Theme.of(context).primaryColor),
              )),
              onPressed: () {
                //do nothing with the button if profile is active
              },
            ),
          );
        } else {
          return Center(
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: (Text(
                'Activeren',
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                // make this the active profile
                model.toggleProfilesInactiveStatus();
                model.selectProfile(profileIndex);
                model.toggleProfileActiveStatus();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          // build the functions
          _buildCloseButton(),
          _buildTitleContainer(),
          Text('Volume: ' + profile.volume.toStringAsFixed(0)),
          _buildIconBar(context),
          _buildIsActiveButton(context),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
