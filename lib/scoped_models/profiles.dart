import 'package:scoped_model/scoped_model.dart';

import '../models/profile.dart';

mixin ProfilesModel on Model {
  List<Profile> _profiles = [];
  int _selectedProfileIndex;
  bool _showFavorites = false;

  List<Profile> get profiles {
    return List.from(_profiles);
  }

  List<Profile> get displayedProfiles {
    if (_showFavorites) {
      return _profiles.where((Profile profile) => profile.isFavorite).toList();
    }
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

  void toggleProfileFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProfile.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Profile updatedProfile = Profile(
      title: selectedProfile.title,
      volume: selectedProfile.volume,
      image: selectedProfile.image,
      isFavorite: newFavoriteStatus,
    );
    _profiles[_selectedProfileIndex] = updatedProfile;
    notifyListeners();
    _selectedProfileIndex = null;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }
}