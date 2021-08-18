import 'dart:async';
import 'dart:convert';

import 'package:ancalmo_manager/models/order_detail_response.dart';
import 'package:ancalmo_manager/models/order_sign_response.dart';
import 'package:ancalmo_manager/models/orders_response.dart';
import 'package:ancalmo_manager/utils/network_util.dart';
import 'package:ancalmo_manager/models/login_response.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.10.101/app";
  static final LOGIN_URL = BASE_URL + "/check_user";
  static final ORDERS_URL = BASE_URL + "/orders_by_user";
  static final ORDER_DETAIL_URL = BASE_URL + "/order_show";
  static final ORDER_SIGN_URL = BASE_URL + "/order_sign";
  //static final _API_KEY = "somerandomkey";

  Future<LoginResponse> login(String username, String password) {
    String strQuery = _addParamToQueryString('', 'email', username);
    strQuery = _addParamToQueryString(strQuery, 'password', password);
    String strRequestUrl = LOGIN_URL + strQuery;

    return _netUtil.get(strRequestUrl).then((dynamic res) {
      LoginResponse response = new LoginResponse.fromJson(res);
      if (response.error.isEmpty) {
        print("succeeded");
        return new LoginResponse.fromJson(res);
      } else {
        print("error");
        throw new Exception(response.error);
      }
    });
  }

  Future<AncalmoOrdersResponse> get_orders(int user_id, int cate_id, [String strSearch]) async {
    strSearch ??= '';
    String strQuery = _addParamToQueryString('', 'user_id', user_id.toString());
    strQuery = _addParamToQueryString(strQuery, 'category', cate_id.toString());
    strQuery = _addParamToQueryString(strQuery, 'srch_val', strSearch);
    String strRequestUrl = ORDERS_URL + strQuery;
    print(strRequestUrl);

    return _netUtil.get(strRequestUrl).then((dynamic res) {
      AncalmoOrdersResponse response = new AncalmoOrdersResponse.fromJson(res);
      if (response.error.isEmpty) {
        print("get_orders succed");
        print(res);
        return new AncalmoOrdersResponse.fromJson(res);
      } else {
        print("error");
        print(strRequestUrl);
        print(res);
        throw new Exception(response.error);
      }
    });
  }

  Future<AncalmoOrderDetailResponse> get_order(int user_id, String order_no) async {
    String strQuery = _addParamToQueryString('', 'user_id', user_id.toString());
    strQuery = _addParamToQueryString(strQuery, 'order_num', order_no);
    String strRequestUrl = ORDER_DETAIL_URL + strQuery;

    return _netUtil.get(strRequestUrl).then((dynamic res) {
      AncalmoOrderDetailResponse response = new AncalmoOrderDetailResponse.fromJson(res);
      if (response.error.isEmpty) {
        print("get_order succed");
        print(res);
        return new AncalmoOrderDetailResponse.fromJson(res);
      } else {
        print("error");
        print(strRequestUrl);
        print(res);
        throw new Exception(response.error);
      }
    });
  }

  Future<OrderSignResponse> order_sign(int user_id, String order_no, bool bReject) {
    String strQuery = _addParamToQueryString('', 'user_id', user_id.toString());
    strQuery = _addParamToQueryString(strQuery, 'order_num', order_no);
    if(bReject) {
      strQuery = _addParamToQueryString(strQuery, 'sign_kind', '2');
    } else {
      strQuery = _addParamToQueryString(strQuery, 'sign_kind', '1');
    }

    String strRequestUrl = ORDER_SIGN_URL + strQuery;
    print(strRequestUrl);

    return _netUtil.get(strRequestUrl).then((dynamic res) {
      OrderSignResponse response = new OrderSignResponse.fromJson(res);
      if (response.error.isEmpty) {
        print("succeeded");
        return new OrderSignResponse.fromJson(res);
      } else {
        print("error");
        throw new Exception(response.error);
      }
    });
  }

  String _addParamToQueryString(String queryString, String key, String value) {
    if (queryString == null) {
      queryString = '';
    }

    if (queryString.length == 0) {
      queryString += '?';
    } else {
      queryString += '&';
    }

    queryString += '$key=$value';

    return queryString;
  }
}
