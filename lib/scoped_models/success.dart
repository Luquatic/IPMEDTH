import 'package:Applaudio/enums/view_states.dart';
import 'package:Applaudio/scoped_models/base.dart';

class SuccessModel extends BaseModel {
  String title = 'no text yet';

  Future fetchDuplicatedText(String text) async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 2));
    title = '$text $text';
    setState(ViewState.Retrieved);
  }
}