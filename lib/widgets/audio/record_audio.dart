//libraries
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
        _profileTitle = 'Profiel: ';
        _profileSubtitle = activeProfileList[0].title;
        _volumeSlider = activeProfileList[0].volume;
      }
      if (favoriteProfileList.length > 0) {
        return ExpansionTile(
          children: favoriteProfileList
              .map((item) => ListTile(
                    title: Text(item.title.length > 0
                        ? _profileTitle = item.title
                        : _profileTitle = 'Profiel: '),
                    onTap: () {
                      model.toggleProfilesInactiveStatus();
                      setState(() {
                        _profileTitle = item.title;
                        _volumeSlider = item.volume;
                        item.isActive = true;
                      });
                    },
                  ))
              .toList(),
          title: Text(_profileTitle),
          trailing: Icon(Icons.keyboard_arrow_down),
        );
      }
      return ListTile(
        // leading: Icon(Icons.account_circle),
        title: Text(_profileTitle),
        subtitle: Text(_profileSubtitle),
        trailing: Icon(Icons.keyboard_arrow_down),
      );
    });
  }

  Widget _buildVolumeSlider() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              // Align(
              //   alignment: Alignment(-0, 0.0),
              //   child: Text('Volume:$roundVolume\n\n'),
              // ),
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
          padding: EdgeInsets.only(bottom: 20),
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
