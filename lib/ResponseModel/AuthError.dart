class AuthError {
  int code;
  String error;
  String email;

  AuthError({this.code, this.error,this.email});

  AuthError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    email = json['email'];
    error = json['error'] != null ? json['error'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['email'] = this.email;
    if (this.error != null) {
      data['error'] = this.error;
    }
    return data;
  }
}
