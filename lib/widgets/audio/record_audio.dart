//libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//models
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';

import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider

final lichtGroen = const Color(0xffB4C42D);
final donkerGroen = const Color(0xff7D8B24);

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

  Widget _buildVolumeSlider() {
    String profile =
        'Get the acutal profile here'; //TODO: Replace dummy text for variable to load the real profile

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            // leading: Icon(Icons.account_circle),
            title: Text('Profiel'),
            subtitle: Text('Huidig profiel'),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),
          // Align(
          //   alignment: Alignment(-0, 0.0),
          //   child: Text('Volume:$roundVolume\n\n'),
          // ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              double _volume = model.volumeValue;
              return FluidSlider(
                value: _volume,
                onChanged: (double value) {
                  setState(() {
                    _volume = value;
                    print(_volume);
                    model.setVolumeSliderValue(_volume);
                  });
                },
                min: 0.0,
                max: 100.0,
              );
            },
          ),
        ],
      ),
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
    return ListView(
      children: <Widget>[
        _buildLogo(),
        _buildVolumeSlider(),
        _buildButtonRow(),
        _buildVolumeWave(),
      ],
    );
  }
}