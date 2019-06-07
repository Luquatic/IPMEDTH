import 'package:flutter/material.dart';

class Profielen extends StatefulWidget {
  @override
  _Profielen createState() => new _Profielen();
}

class _Profielen extends State<Profielen> {
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
              Navigator.pushNamed(context, '/profielen');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView(children: <Widget>[
       
      ]),
      floatingActionButton:FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: new Color(0xFFB4C42D),
      onPressed: () {
         Navigator.pushNamed(context, '/addprofiel');
      },
    )
    );
  }
}
