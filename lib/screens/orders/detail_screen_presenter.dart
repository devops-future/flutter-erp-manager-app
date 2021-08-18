import 'package:ancalmo_manager/data/rest_ds.dart';
import 'package:ancalmo_manager/models/login_response.dart';
import 'package:ancalmo_manager/models/order_sign_response.dart';
//import 'package:shared_preferences/shared_preferences.dart';

abstract class DetailScreenContract {
  void onSignSuccess();

  void onSignError(String errorTxt);
}

class DetailScreenPresenter {
  DetailScreenContract _view;
  RestDatasource api = new RestDatasource();

  DetailScreenPresenter(view) {
    this._view = view;
  }

  doSign(int user_id, String order_no, bool bReject) async {
    try {
      OrderSignResponse response = await api.order_sign(user_id, order_no, bReject);
      _view.onSignSuccess();
    } catch (e) {
      _view.onSignError(e.toString().substring(e.toString().indexOf(":") + 1));
    }
  }
}
