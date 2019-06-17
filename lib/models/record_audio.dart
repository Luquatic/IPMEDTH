import 'package:flutter/material.dart';

class RecordAudio {
  final double volume;
  final bool isRecording;

  RecordAudio({@required this.volume, this.isRecording = false});
}