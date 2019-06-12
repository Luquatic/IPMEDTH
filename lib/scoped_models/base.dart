import 'package:Applaudio/enums/view_states.dart';
import 'package:scoped_model/scoped_model.dart';

// export 'package:scoped_guide/enums/view_states.dart';

class BaseModel extends Model {
  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}