import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/profile.dart';
import '../scoped_models/profile.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProfile;
  final Function updateProfile;
  final Profile profile;
  final int profileIndex;

  ProductEditPage(
    {this.addProfile, this.updateProfile, this.profile, this.profileIndex}
  )

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}