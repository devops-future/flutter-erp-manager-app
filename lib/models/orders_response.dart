import 'package:ancalmo_manager/models/db_structure.dart';

class AncalmoOrdersResponse {
  List<AncalmoOrder> rows;
  String status;
  String error;

  AncalmoOrdersResponse({this.rows, this.status, this.error});

  AncalmoOrdersResponse.fromJson(Map<String, dynamic> json) {
    error = json['status'] == 'ok' ? '' : json['error'];
    status = json['status'];
    if(json['rows'] != null) {
      rows = new List();
      for (int i = 0; i < json['rows'].length; i++) {
        rows.add(AncalmoOrder.fromJson(json['rows'][i]));
      }
    }
  }
}
