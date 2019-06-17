import 'package:scoped_model/scoped_model.dart';

import './profiles.dart';
import './record_audio.dart';
import './user.dart';

class MainModel extends Model with ProfilesModel, RecordAudioModel, UserModel {}