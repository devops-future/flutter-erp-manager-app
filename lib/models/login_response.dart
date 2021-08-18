class LoginResponse {
  String error = '';
  int user_id = 0;
  String status = '';

  LoginResponse({this.user_id, this.status, this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['status'] == 'ok' ? '' : json['status'];
    user_id = json['status'] == 'ok' ? json['user_id'] : 0;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (this.user_id != 0) {
      data['user_id'] = this.user_id;
    }
    return data;
  }
}
