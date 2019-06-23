import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import 'package:flutter_fluid_slider/flutter_fluid_slider.dart'; //Fluid Slider
import 'package:flutter/services.dart';

import '../models/profile.dart';

mixin ConnectedProfilesModel on Model {
  List<Profile> _profiles = [];

  int _selectedProfileIndex;
  bool _showFavorites = false;
  bool _isRecording = false;
  int _collapseKey;

  static const _platform = const MethodChannel('audiorecorder');

  Profile get selectedProfile {
    if (_selectedProfileIndex == null) {
      return null;
    }
    return _profiles[_selectedProfileIndex];
  }
}

mixin ProfilesModel on ConnectedProfilesModel {
  List<Profile> get profiles {
    return List.from(_profiles);
  }

  List<Profile> get displayedProfiles {
    if (_showFavorites) {
      return _profiles.where((Profile profile) => profile.isFavorite).toList();
    }
    return List.from(_profiles);
  }

  List<Profile> get displayFavoriteProfiles {
     return _profiles.where((Profile profile) => profile.isFavorite).toList();
  }

  List<Profile> get displayActiveProfile {
     return _profiles.where((Profile profile) => profile.isActive).toList();
  }

  int get selectedProfileIndex {
    return _selectedProfileIndex;
  }

  void addProfile(Profile profile) {
    _profiles.add(profile);
    _selectedProfileIndex = null;
    notifyListeners();
  }

  void updateProfile(Profile profile) {
    _profiles[_selectedProfileIndex] = profile;
    _selectedProfileIndex = null;
    notifyListeners();
  }

  void deleteProfile() {
    _profiles.removeAt(_selectedProfileIndex);
    _selectedProfileIndex = null;
    notifyListeners();
  }

  void selectProfile(int index) {
    _selectedProfileIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

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

  void toggleProfilesInactiveStatus() {
     for(var i = 0; i<_profiles.length; i++) {
      _profiles[i].isActive = false;
    }
  }

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

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }
}

mixin RecordAudioModel on ConnectedProfilesModel {
  bool get isRecording {
    return _isRecording;
  }

  Future<void> toggleAudioRecordingEcho() async {
    try {
      await ConnectedProfilesModel._platform
          .invokeMethod('toggleAudioRecordingEcho');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<double> setVolumeSliderValue(double value) async {
    double result;
    try {
      result = await ConnectedProfilesModel._platform
          .invokeMethod('setVolumeSliderValue', {"waarde": value});
    } on PlatformException catch (e) {
      print(e.message);
    }
    return result;
  }

  void startRecorder() {
    toggleAudioRecordingEcho();
    _isRecording = true;
    notifyListeners();
  }

  void stopRecorder() {
    toggleAudioRecordingEcho();
    _isRecording = false;
    notifyListeners();
  }
}
