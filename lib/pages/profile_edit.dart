import 'package:flutter/material.dart';

import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/profiles.dart';
import '../models/profile.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileEditPageState();
  }
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'volume': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Profile profile) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Titel'),
      initialValue: profile == null ? '' : profile.title,
      validator: (String value) {
        if (value.length < 3) {
          return 'Titel is vereist';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildVolumeFluidsider(Profile profile) {
    return FluidSlider(
      value: profile.volume,
      onChanged: (double value) {
        setState(() {
          _formData['volume'] = value;
          // _setWaarde(_volume);
        });
      },
      min: 0.0,
      max: 100.0,
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProfilesModel>(
      builder: (BuildContext context, Widget child, ProfilesModel model) {
        return RaisedButton(
          child: Text('Opslaan'),
          onPressed: () => _submitForm(model.addProfile, model.updateProfile,
              model.selectedProfileIndex),
        );
      },
    );
  }

  void _submitForm(Function addProfile, Function updateProfile,
      [int selectedProfileIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProfileIndex == null) {
      addProfile(Profile(
        title: _formData['title'],
        volume: _formData['volume'],
      ));
    } else {
      updateProfile(Profile(
        title: _formData['title'],
        volume: _formData['volume'],
      ));
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  Widget _buildPageContent(BuildContext context, Profile profile) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiel toevoegen'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              // padding: EdgeInsets.symmetric(horizontal:),
              children: <Widget>[
                _buildTitleTextField(profile),
                _buildVolumeFluidsider(profile),
                SizedBox(
                  height: 10.0,
                ),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>(
      builder: (BuildContext context, Widget child, ProfilesModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProfile);
        return model.selectedProfileIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Wijzig profiel'),
                ),
              );
      },
    );
  }
}
