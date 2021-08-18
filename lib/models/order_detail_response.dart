import 'package:ancalmo_manager/models/db_structure.dart';

class AncalmoOrderDetailResponse {
  List<OrderItem> details;
  String error;
  String status;
  String order_no;
  String applicant;
  String department;
  String manager_name;
  String director_name1;
  String director_name2;
  String director_name3;

  AncalmoOrderDetailResponse({this.details, this.status, this.error, this.order_no, this.applicant, this.department});

  AncalmoOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    error = json['status'] == 'ok' ? '' : json['status'];
    status = json['status'];

    if(json['order'] == null || json['order']['numero_orden'] == null) {
      order_no = '';
    } else {
      order_no = json['order']['numero_orden'];
    }

    if(json['order'] == null || json['order']['nombre_persona_despachar'] == null) {
      applicant = '';
    } else {
      applicant = json['order']['nombre_persona_despachar'];
    }

    if(json['order'] == null || json['order']['nombre_persona_facturar'] == null) {
      department = '';
    } else {
      department = json['order']['nombre_persona_facturar'];
    }

    if(json['order_m'] == null || json['order_m']['manager_name'] == null) {
      manager_name = '';
    } else {
      manager_name = json['order_m']['manager_name'];
    }

    if(json['order_m'] == null || json['order_m']['director_name1'] == null) {
      director_name1 = '';
    } else {
      director_name1 = json['order_m']['director_name1'];
    }

    if(json['order_m'] == null || json['order_m']['director_name2'] == null) {
      director_name2 = '';
    } else {
      director_name2 = json['order_m']['director_name2'];
    }

    if(json['order_m'] == null || json['order_m']['director_name3'] == null) {
      director_name3 = '';
    } else {
      director_name3 = json['order_m']['director_name3'];
    }

    if(json['order_detail'] != null) {
      details = new List();
      for (int i = 0; i < json['order_detail'].length; i++) {
        details.add(OrderItem.fromJson(json['order_detail'][i]));
      }
    }
  }
}
