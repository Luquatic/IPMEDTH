//libraries
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';
import '../../models/profile.dart';

//Widgets
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider

final lichtGroen = const Color(0xffB4C42D);
final donkerGroen = const Color(0xff7D8B24);

String _profileTitle;
String _profileSubtitle;
double _volumeSlider = 0.0;

class RecordAudio extends StatefulWidget {
  @override
  _RecordAudioState createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
   int _key;

      _collapse() {
        int newKey;
        do {
          _key = new Random().nextInt(10000);
        } while(newKey == _key);
      }

      @override
      void initState() {
        super.initState();
        _collapse();
      }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 15),
      child: Image.asset('res/images/logo.png', height: 70.0, width: 70.0),
    );
  }

  Widget _buildSelectProfile(
      List<Profile> activeProfileList, List<Profile> favoriteProfileList) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (activeProfileList.length < 1) {
        _profileTitle = 'Geen profiel geselecteerd';
        _profileSubtitle = '';
      } else {
        _profileTitle = 'Actief profiel: ';
        _profileSubtitle = activeProfileList[0].title;
        _volumeSlider = activeProfileList[0].volume;
      }
      if (favoriteProfileList.length > 0) {
        if (activeProfileList.length > 0) {
          _profileTitle = 'Actief profiel: ' + activeProfileList[0].title;
          _profileSubtitle = activeProfileList[0].title;
          _volumeSlider = activeProfileList[0].volume;
        }
        return ExpansionTile(
          key: Key(_key.toString()),
          initiallyExpanded: false,
          children: favoriteProfileList
              .map((item) => ListTile(
                    title: Text(item.title, textAlign: TextAlign.center,),
                    onTap: () {
                      model.toggleProfilesInactiveStatus();
                      setState(() {
                        _profileTitle = item.title;
                        _volumeSlider = item.volume;
                        item.isActive = true;
                        model.setVolumeSliderValue(_volumeSlider);
                      });
                       _collapse();
                    },
                  ))
              .toList(),
          title: Text(_profileTitle, textAlign: TextAlign.center,),
          trailing: Icon(Icons.keyboard_arrow_down),
        );
      }
      return ListTile(
        contentPadding: EdgeInsets.only(top: 10),
        title: Text('$_profileTitle$_profileSubtitle', textAlign: TextAlign.center,),
      );
    });
  }

  Widget _buildVolumeSlider() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              FluidSlider(
                value: _volumeSlider,
                onChanged: (double value) {
                  model.toggleProfilesInactiveStatus();
                  setState(() {
                    _volumeSlider = value;
                    model.setVolumeSliderValue(_volumeSlider);
                  });
                },
                min: 0.0,
                max: 100.0,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonRow() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              child: ClipOval(
                child: FlatButton(
                  onPressed: () {
                    if (!model.isRecording) {
                      return model.startRecorder();
                    }
                    model.stopRecorder();
                  },
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: model.isRecording
                        ? AssetImage('res/icons/mic-off.png')
                        : AssetImage('res/icons/mic-on.png'),
                  ),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        );
      },
    );
  }

  Widget _buildVolumeWave() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: Image(
              image: model.isRecording
                  ? AssetImage('res/images/wave.gif')
                  : AssetImage('res/images/wave.png')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView(
        children: <Widget>[
          _buildLogo(),
          _buildSelectProfile(
              model.displayActiveProfile, model.displayFavoriteProfiles),
          _buildVolumeSlider(),
          _buildButtonRow(),
          _buildVolumeWave(),
        ],
      );
    });
  }
}
