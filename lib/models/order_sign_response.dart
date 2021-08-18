class OrderSignResponse {
  String error = '';
  String status = '';

  OrderSignResponse({this.status, this.error});

  OrderSignResponse.fromJson(Map<String, dynamic> json) {
    error = json['status'] == 'ok' ? '' : json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    return data;
  }
}
