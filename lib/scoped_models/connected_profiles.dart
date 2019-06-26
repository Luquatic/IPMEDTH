/*
  this file includes the functions for the defined models
*/

//libraries
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
// models
import '../models/profile.dart';
// mixin to connect the models
mixin ConnectedProfilesModel on Model {
  // store the list of profiles
  List<Profile> _profiles = [];
  // required variables
  int _selectedProfileIndex;
  bool _showFavorites = false;
  bool _isRecording = false;
  // load the native method channel here (this is used to call the cpp code)
  static const _platform = const MethodChannel('audiorecorder');
  // get the selected profile
  Profile get selectedProfile {
    if (_selectedProfileIndex == null) {
      return null;
    }
    return _profiles[_selectedProfileIndex];
  }
}
// define the functions for the profiles
mixin ProfilesModel on ConnectedProfilesModel {
  // get all the profiles
  List<Profile> get profiles {
    return List.from(_profiles);
  }
  // display the profiles
  List<Profile> get displayedProfiles {
    // you can show only the favorite or all profiles
    if (_showFavorites) {
      return _profiles.where((Profile profile) => profile.isFavorite).toList();
    }
    return List.from(_profiles);
  }
  // show the favorite profiles only (used for the list in the homepage)
  List<Profile> get displayFavoriteProfiles {
     return _profiles.where((Profile profile) => profile.isFavorite).toList();
  }
  // display the active profile
  List<Profile> get displayActiveProfile {
     return _profiles.where((Profile profile) => profile.isActive).toList();
  }
  // get the index of the selected profile
  int get selectedProfileIndex {
    return _selectedProfileIndex;
  }
  // add a new profile
  void addProfile(Profile profile) {
    _profiles.add(profile);
    _selectedProfileIndex = null;
    notifyListeners();
  }
  // edit an existing profile
  void updateProfile(Profile profile) {
    _profiles[_selectedProfileIndex] = profile;
    _selectedProfileIndex = null;
    notifyListeners();
  }
  // delete an exisiting profile
  void deleteProfile() {
    _profiles.removeAt(_selectedProfileIndex);
    _selectedProfileIndex = null;
    notifyListeners();
  }
  // select a profile by index
  void selectProfile(int index) {
    _selectedProfileIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }
  // toggle the favorite status to display only favorites or all profiles
  void toggleProfileFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProfile.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Profile updatedProfile = Profile(
      title: selectedProfile.title,
      volume: selectedProfile.volume,
      isFavorite: newFavoriteStatus,
      isActive: selectedProfile.isActive,
    );
    _profiles[_selectedProfileIndex] = updatedProfile;
    _selectedProfileIndex = null;
    notifyListeners();
  }
  // toggle the active status of a profile. There can only be one active profile at a time
  void toggleProfilesInactiveStatus() {
     for(var i = 0; i<_profiles.length; i++) {
      _profiles[i].isActive = false;
    }
  }
  // change the status of the active profile
  void toggleProfileActiveStatus() {
    final Profile updatedProfile = Profile(
      title: selectedProfile.title,
      volume: selectedProfile.volume,
      isFavorite: selectedProfile.isFavorite,
      isActive: true,
    );
    _profiles[_selectedProfileIndex] = updatedProfile;
    _selectedProfileIndex = null;
    notifyListeners();
  }
  // toggle the display of the favorite profiles
  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
  // get the favorites
  bool get displayFavoritesOnly {
    return _showFavorites;
  }
}
// define the functions for the RecordAudioModel
mixin RecordAudioModel on ConnectedProfilesModel {
  // get the isRecording variable
  bool get isRecording {
    return _isRecording;
  }
  // this function toggles the on/off state of the audio recording
  Future<void> toggleAudioRecordingEcho() async {
    try {
      // this function is called in mainactivity.java 
      await ConnectedProfilesModel._platform
          .invokeMethod('toggleAudioRecordingEcho');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  // this functions adjusts the volume while recording
  Future<double> setVolumeSliderValue(double value) async {
    double result;
    try {
      // this functions is linked in mainactivity.java, and called in AudioEffect.cpp
      result = await ConnectedProfilesModel._platform
          .invokeMethod('setVolumeSliderValue', {"waarde": value});
    } on PlatformException catch (e) {
      print(e.message);
    }
    return result;
  }
  // start recording
  void startRecorder() {
    toggleAudioRecordingEcho();
    _isRecording = true;
    notifyListeners();
  }
  // stop recording
  void stopRecorder() {
    toggleAudioRecordingEcho();
    _isRecording = false;
    notifyListeners();
  }
}
