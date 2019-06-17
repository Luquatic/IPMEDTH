import 'package:flutter/material.dart';

class Profile {
  final String title;
  final double volume;
  final String image;
  final bool isFavorite;

  Profile({@required this.title, @required this.volume, @required this.image, this.isFavorite = false});
}