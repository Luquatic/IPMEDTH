import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:flutter_xlider/flutter_xlider.dart';

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

    // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

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

  Widget _buildBatery(){
    return Material(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            child: Text('Get Battery Level'),
            onPressed: _getBatteryLevel,
          ),
          Text(_batteryLevel),
        ],
      ),
    ),
  );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 15),
      child: Image.asset('res/images/logo.png', height: 70.0, width: 70.0),
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
      margin: EdgeInsets.only(top: 24.0,left:10,right:10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment(-0, 0.0),
            child: Text('Profiel: $profile \n\n'),
          ),
          Align(
            alignment: Alignment(-0, 0.0),
            child: Text('Volume:$roundVolume\n\n'),
          ),
          FlutterSlider(
            values: [_value],
            min: 0,
            max: 100,
            //axis: Axis.vertical,

            onDragging: (handlerIndex, lowerValue, upperValue) {
              upperValue = upperValue;

              setState(() {
              _value = lowerValue;
              _setWaarde(_value);
              });
            },
          ),
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
        //_buildRecordingColumn(),
        _buildButtonRow(),
        _buildBatery()
      ],
    );
  }
}
