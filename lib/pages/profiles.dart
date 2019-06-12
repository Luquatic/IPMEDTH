import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

import 'package:Applaudio/libraries/data_storage.dart';

class Profiles extends StatefulWidget {
  final DataStorage dataStorage;

  const Profiles({Key key, this.dataStorage}) : super(key: key);

  @override
  _Profiles createState() => _Profiles();
}

class _Profiles extends State<Profiles> {
  String _profileName = '';
  double _value = 0.0;

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

  Future<String> _addProfileDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voeg een profiel toe'),
          content: Container(
              child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                  'Voeg hier een profiel toe om deze in het hoofdmenu te gebruiken. Hierdoor heb je altijd snel je instellingen bij de hand.'),
              SizedBox(height: 15),
              Text('Profiel naam:'),
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Naam van profiel ...'),
                onChanged: (value) {
                  this.setState(() {
                    _profileName = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text('Volume:'),
              SizedBox(height: 15),
              FluidSlider(
                value: _value,
                onChanged: (double newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
                min: 0.0,
                max: 100.0,
              ),
            ],
          )),
          actions: <Widget>[
            FlatButton(
              child: Text('Afsluiten'),
              onPressed: () {
                this.setState(() {
                  //reset parameters if user closed the box
                  _profileName = '';
                  _value = 0.0;
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Opslaan'),
              onPressed: () {
                Navigator.of(context).pop(_profileName);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getProfiles() {
    //TODO: check if there are profiles and view them, if there are no profiles show that instead
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text(''),
        ),
        body: ListView(children: <Widget>[]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFFB4C42D),
          onPressed: () async {
            await _addProfileDialog(context);
          },
        ));
  }
}
