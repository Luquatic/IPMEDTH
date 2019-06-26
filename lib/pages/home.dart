/*
  this file is used to make the menu bar and load the RecordAudio widget
*/

//libraries
import 'package:flutter/material.dart';

//widgets
import '../widgets/audio/record_audio.dart';

class HomePage extends StatelessWidget {
  // make the menu
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text('Profielen'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profiles');
            },
          ),
          ListTile(
            leading: Icon(Icons.chrome_reader_mode),
            title: Text('Handleiding'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tutorial');
            },
          ),
        ],
      ),
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
      // create the menu
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text(''),
      ),
      // load the recordAudio widget
      body: RecordAudio(),
      // bottomNavigationBar: _buildVolumeWave(),
    );
  }
}
