class AuthError {
  int code;
  String error;

  AuthError({this.code, this.error});

  AuthError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'] != null ? json['error'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.error != null) {
      data['error'] = this.error;
    }
    return data;
  }
}
