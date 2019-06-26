import 'package:flutter/material.dart';

class Profile {
  // fields used for creating a profile
  final String title;
  double volume;
  final bool isFavorite;
  bool isActive;

  Profile({@required this.title, @required this.volume, this.isFavorite = false, this.isActive = false});
}