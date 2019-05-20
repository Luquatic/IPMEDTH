import 'package:flutter/material.dart';

import '../RecordAudio.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Applaudio!'),
        ),
        body:RecordAudio()
      );
  }
}