import 'package:flutter/material.dart';


class Profielen extends StatefulWidget {
  @override
  _Profielen createState() => new _Profielen();
}

class _Profielen extends State<Profielen> {
  
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 15),
      child: Image.asset('res/images/logo.png', height: 70.0, width: 70.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        // actions: <Widget>[
        //   PopupMenuButton<String>(itemBuilder: (BuildContext context) {
        //     return Constants.choices.map((String choice) {
        //       return PopupMenuItem<String>(
        //         value: choice,
        //         child: Text(choice),
        //       );
        //     }).toList();
        //   })
        // ],
      ),
      body: _buildLogo(),
    );
  }
}
