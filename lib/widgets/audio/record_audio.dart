import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

class RecordAudio extends StatefulWidget {
  @override
  _RecordAudioState createState() => new _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  bool _isRecording = false;
  FlutterSound flutterSound;

  String _recorderTxt = '00:00:00';
  double _dbLevel;
  //TODO: Adjust eventually the values for the volume slider and replace this for the _dbLevel
  double _value = 0.0;

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
      //TODO: acces variable from Java here to set the right state (this is only neccessary for changing the button)
      // if () {
      //   this.setState(() {
      //     this._isRecording = true;
      //   });
      // } else {
      //   this.setState(() {
      //     this._isRecording = false;
      //   });
      // }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 15),
      child: Image.asset('res/images/logo.png'),
    );
  }

  Widget _buildRecordingColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Text(
            this._recorderTxt,
            style: TextStyle(
              fontSize: 48.0,
              color: Colors.black,
            ),
          ),
        ),
        _isRecording
            ? LinearProgressIndicator(
                value: 100.0 / 160.0 * (this._dbLevel ?? 1) / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.red,
              )
            : Container()
      ],
    );
  }

  Widget _buildVolumeSlider() {
    String roundVolume = _value.toStringAsFixed(1);
    String profile =
        'Get the acutal profile here'; //TODO: Replace dummy text for variable to load the real profile

    return Container(
      margin: EdgeInsets.only(top: 24.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment(-0.8, 0.0),
            child: Text('Profiel: $profile \n\n'),
          ),
          Align(
            alignment: Alignment(-0.9, 0.0),
            child: Text('Volume:$roundVolume\n\n'),
          ),
          Slider(
              value: _value,
              min: 0.0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _value = value;
                  _setWaarde(_value);
                });
              })
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          child: ClipOval(
            child: FlatButton(
              onPressed: () {
                _toggleEcho();
              },
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: this._isRecording
                    ? AssetImage('res/icons/ic_stop.png')
                    : AssetImage('res/icons/ic_mic.png'),
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
        //_buildRecordingColumn(),
        _buildButtonRow()
      ],
    );
  }
}
