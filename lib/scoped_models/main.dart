/*
  in this file the models are connected to this main model
*/

import 'package:scoped_model/scoped_model.dart';

import './connected_profiles.dart';

class MainModel extends Model with ConnectedProfilesModel, ProfilesModel, RecordAudioModel {}