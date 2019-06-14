import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider

final lichtGroen = const Color(0xffB4C42D);
final donkerGroen = const Color(0xff7D8B24);

class RecordAudio extends StatefulWidget {
  @override
  _RecordAudioState createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  bool _isRecording = false;

  //TODO: Adjust eventually the values for the volume slider and replace this for the _dbLevel
  double _volume = 0.0;

  static const platform = const MethodChannel('audiorecorder');

  Future<double> _setWaarde(double waarde) async {
    double result = 0.0;
    try {
      result = await platform.invokeMethod('setWaarde', {"waarde": waarde});
    } on PlatformException catch (e) {
      print(e.message);
    }
    return result;
  }

  Future<void> _toggleEcho() async {
    try {
      await platform.invokeMethod('toggleEcho');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void startRecorder() {
    _toggleEcho();
    this.setState(() {
      this._isRecording = true;
    });
  }

  void stopRecorder() {
    _toggleEcho();
    this.setState(() {
      this._isRecording = false;
    });
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 15),
      child: Image.asset('res/images/logo.png', height: 70.0, width: 70.0),
    );
  }

  Widget _buildVolumeSlider() {
    String roundVolume = _volume.toStringAsFixed(1);
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
          FluidSlider(
            value: _volume,
            onChanged: (double newValue) {
              setState(() {
                _volume = newValue;
                _setWaarde(_volume);
              });
            },
            min: 0.0,
            max: 100.0,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      children: <Widget>[
        Container(
          width: 100.0,
          height: 100.0,
          child: ClipOval(
            child: FlatButton(
              onPressed: () {
                if (!this._isRecording) {
                  return this.startRecorder();
                }
                this.stopRecorder();
              },
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: this._isRecording
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildLogo(), 
        _buildVolumeSlider(), 
        _buildButtonRow(),
        ],
    );
  }
}
