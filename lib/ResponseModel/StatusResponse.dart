import 'Data.dart';

class StatusResponse {
  bool status;
  int code;
  Data data;
  String error;

  StatusResponse(this.status, this.code, this.data, this.error);

  StatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;


    error = json['error'];
    print("==========> "+error.toString());

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error;
    }
    return data;
  }
}
