import 'package:flutter/material.dart';

class Profile {
  final String title;
  final double volume;
  final bool isFavorite;

  Profile({@required this.title, @required this.volume, this.isFavorite = false});
}