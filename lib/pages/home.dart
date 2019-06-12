import 'package:flutter/material.dart';

import '../widgets/audio/record_audio.dart';
// import '../widgets/ui_elements/constants.dart';

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
          leading: Icon(Icons.list),
          title: Text('Home'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Profielen'),
          onTap: () {
            Navigator.pushNamed(context, '/profiles');
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
        // actions: <Widget>[
        //   PopupMenuButton<String>(itemBuilder: (BuildContext context) {
        //     return Constants.choices.map((String choice) {
        //       return PopupMenuItem<String>(
        //         value: choice,
        //         child: Text(choice),
        //       );
        //     }).toList();
        //   })
        // ],
      ),
      body: RecordAudio(),
      bottomNavigationBar: _buildVolumeWave(),
      );
  }
  // void choiceAction(String choice) {
  //   if (choice == Constants.Settings) {
  //     print('Settings');
  //   }
  // }
}
