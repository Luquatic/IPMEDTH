//libraries
import 'package:flutter/material.dart';

//widgets
import '../widgets/audio/record_audio.dart';

class HomePage extends StatelessWidget {
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
            title: Text('Help'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/intro');
            },
          ),
        ],
      ),
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text(''),
      ),
      body: RecordAudio(),
      // bottomNavigationBar: _buildVolumeWave(),
    );
  }
}
