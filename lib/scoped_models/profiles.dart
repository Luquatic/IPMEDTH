import 'package:scoped_model/scoped_model.dart';

import '../models/profile.dart';

mixin ProfilesModel on Model {
  List<Profile> _profiles = [];
  int _selectedProfileIndex;

  List<Profile> get profiles {
    return List.from(_profiles);
  }

  int get selectedProfileIndex {
    return _selectedProfileIndex;
  }

  Profile get selectedProfile {
    if (_selectedProfileIndex == null) {
      return null;
    }
    return _profiles[_selectedProfileIndex];
  }

  void addProfile(Profile profile) {
    _profiles.add(profile);
    _selectedProfileIndex = null;
  }

  void updateProfile(Profile profile) {
    _profiles[_selectedProfileIndex] = profile;
    _selectedProfileIndex = null;
  }

  void deleteProfile() {
    _profiles.removeAt(_selectedProfileIndex);
    _selectedProfileIndex = null;
  }

  void selectProfile(int index) {
    _selectedProfileIndex = index;
  }
}