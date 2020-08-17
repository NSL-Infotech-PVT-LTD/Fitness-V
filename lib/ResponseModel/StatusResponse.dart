import 'AuthError.dart';
import 'Data.dart';

class StatusResponse {
  bool status;
  int code;
  Data data;
  String error;
  AuthError errors;

  StatusResponse(this.status, this.code, this.data, this.error);

  StatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    print("==========> "+json['data'] .toString());

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;


    error = json['error'];
    errors = json['errors']!=null?new AuthError.fromJson(json['errors']):null;

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
    }else if(this.errors !=null){
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}
