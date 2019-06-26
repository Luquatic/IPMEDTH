/*
  this file is used to create/edit a profile
*/

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
  // store the title and the volume
  final Map<String, dynamic> _formData = {'title': null, 'volume': null};
  // make a key (id) for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // initialize variable for the volumeSlider
  double _volumeSlider = 0.0;
  // build the Title field
  Widget _buildTitleTextField(Profile profile) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Titel'),
      // check if there is a profile title and display that title if there is. Otherwise display an empty field (create/edit)
      initialValue: profile == null ? '' : profile.title,
      validator: (String value) {
        // title must be at least one character
        if (value.length < 1) {
          return 'Titel is vereist';
        }
      },
      // save the title
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  // build the slider
  Widget _buildVolumeSlider(Profile profile) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        //if slider is not changed, pass the actual value
        if (profile != null) {
          // TODO: change this to the right value
          _formData['volume'] =  profile.volume;
        }
        // pass the value even if the slider is not changed. That way errors will be prevented.
        else {
          _formData['volume'] = _volumeSlider;
        }
        return FluidSlider(
          value: _formData['volume'],
          // set the new state of the volumeslider and save it to the formData
          onChanged: (double value) {
            setState(() {
              if(profile != null){
                profile.volume = value;
                _formData['volume'] = value;
              }
              _volumeSlider = value;  
              _formData['volume'] = value;
            });
          },
          min: 0.0,
          max: 100.0,
        );
      },
    );
  }

  // build submit button
  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Opslaan'),
          // save the formData onpressed. Call the right methods from the scoped_model
          onPressed: () => _submitForm(model.addProfile, model.updateProfile,
              model.selectedProfileIndex),
        );
      },
    );
  }

  // save the submitForm
  void _submitForm(Function addProfile, Function updateProfile,
      [int selectedProfileIndex]) {
    // check validation
    if (!_formKey.currentState.validate()) {
      return;
    }
    // save the state of the form
    _formKey.currentState.save();
    // check if it was an update or add
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
    // return to the profiles screen
    Navigator.pushNamed(context, '/profiles');
  }

  // build the form page
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
            children: <Widget>[
              // call the functions to build the textfield, volumeslider and submit button
              _buildTitleTextField(profile),
              SizedBox(
                height: 70.0,
              ),
              _buildVolumeSlider(profile),
              SizedBox(
                height: 20.0,
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
    // build the content with the model
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // store the _buildPageContent function
        final Widget pageContent =
            _buildPageContent(context, model.selectedProfile);
        // check if a profile is added or edited and display the right title in the appBar
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
