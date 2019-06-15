import 'package:flutter/material.dart';

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
        title: Text('Profielen'),
      ),
      body: ProfilesList(),
      floatingActionButton: _buildFloatingActionButton(context, 0),
    );
  }
}
