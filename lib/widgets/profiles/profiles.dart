/*
  this file builds a list of the profile cards
*/
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/profile.dart';
import '../../scoped_models/main.dart';

import './profile_card.dart';


class Profiles extends StatelessWidget {
  // build the profileCardList
  Widget _buildProfileCardList(List<Profile> profiles) {
    Widget profileCards;
    if (profiles.length > 0) {
      profileCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProfileCard(profiles[index], index),
        itemCount: profiles.length,
      );
    } else {
      // if there are no profiles, dispaly only a text
      profileCards = Center(
        child: Text('Geen profielen gevonden'),
      );
    }
    return profileCards;
  }

  @override
  Widget build(BuildContext context) {
    // return the list
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProfileCardList(model.displayedProfiles);
    },); 
  }
}
