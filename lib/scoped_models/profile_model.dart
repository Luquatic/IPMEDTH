import 'package:Applaudio/enums/view_states.dart';
import 'package:Applaudio/scoped_models/base_model.dart';
import 'package:Applaudio/service_locator.dart';
import 'package:Applaudio/services/storage_service.dart';

class ProfileModel extends BaseModel {
  StorageService storageService = locator<StorageService>();

  String title = 'model test';

  ViewState _state;
  ViewState get state => _state;

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    title = 'Saving data';
    await storageService.saveData();
    title = 'Data saved';
    setState(ViewState.Retrieved);

    return true;
  }
}