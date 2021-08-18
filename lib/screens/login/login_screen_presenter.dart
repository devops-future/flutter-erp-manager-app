import 'package:ancalmo_manager/data/rest_ds.dart';
import 'package:ancalmo_manager/models/login_response.dart';
//import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LoginResponse response);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();

  LoginScreenPresenter(view) {
    this._view = view;
  }

  doLogin(String username, String password) async {
    try {
      LoginResponse response = await api.login(username, password);
      print('doLogin:' + response.user_id.toString() + response.status);
      print(_view);
      _view.onLoginSuccess(response);
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('username', username);
    } catch (e) {
      _view.onLoginError(e.toString().substring(e.toString().indexOf(":") + 1));
      //_view.onLoginError('No es posible conectarse al servidor. Verifique la conexión de red.');
    }
  }
}
