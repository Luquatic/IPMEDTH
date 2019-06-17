import 'package:flutter/material.dart';
import '../widgets/audio/record_audio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageButtonState createState() => _HomePageButtonState();
}

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
            Navigator.popAndPushNamed(context, '/profiles');
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

Widget _buildVolumeWave() {
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: Image.asset('res/images/wave.gif'),
  );
}

class _HomePageButtonState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text(''),
      ),
      body: RecordAudio(),
      bottomNavigationBar: _buildVolumeWave(),
    );
  }
}
