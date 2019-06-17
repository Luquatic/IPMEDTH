import 'package:flutter/material.dart';

class ProfielenUitlegDialog extends StatelessWidget {
  Widget _buildUitlegDialog() {
    return SimpleDialog(
      title: Text('Applaudio! profielen'),
      children: <Widget>[
        SimpleDialogOption(
          child: Text('Profielen uitleggen.'),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text('Vorige'),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('Volgende'),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildUitlegDialog();
  }
}
