//libraries
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider

//models
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
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
    'image': 'res/images/cafe.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Profile profile) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Titel'),
      initialValue: profile == null ? '' : profile.title,
      validator: (String value) {
        if (value.length < 1) {
          return 'Titel is vereist';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

   Widget _buildVolumeSider(Profile profile) {
     return Slider(
       activeColor: Colors.indigoAccent,
       min: 0.0,
       max: 100.0,
       onChanged: (volume) {
         setState(() => _formData['volume'] = volume);
       },
       value: _formData['volume'],
      );
   }

  Widget _buildVolumeTextfield(Profile profile) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Volume'),
      initialValue: profile == null ? '' : profile.volume.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Volume is vereist';
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Volume moet een getal zijn';
        }
      },
      onSaved: (String value) {
        _formData['volume'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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
        image: _formData['image'],
      ));
    } else {
      updateProfile(Profile(
        title: _formData['title'],
        volume: _formData['volume'],
        image: _formData['image'],
      ));
    }
    Navigator.pushNamed(context, '/profiles');
  }

  Widget _buildPageContent(BuildContext context, Profile profile) {
    return GestureDetector(
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
              _buildVolumeTextfield(profile),

              //_buildVolumeSider(profile), ToDo- fix layout so slider is available

              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProfile);
        return model.selectedProfileIndex == null
            ? Scaffold(
              appBar: AppBar(
                title: Text('Profiel toevoegen'),
              ),
              body: pageContent,
            )
            : Scaffold(
                appBar: AppBar(
                  title: Text('Wijzig profiel'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
