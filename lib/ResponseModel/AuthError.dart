class AuthError {
  String email;
  String email_1;
  String email_2;
  String email_3;
  String mobile;
  String mobile_1;
  String mobile_2;
  String mobile_3;
  String emirate_image1;
  String emirate_image2;

  AuthError(
      {this.email,
      this.email_1,
      this.email_2,
      this.email_3,
      this.mobile,
      this.mobile_1,
      this.mobile_2,
      this.mobile_3,
      this.emirate_image1,
      this.emirate_image2,
      });

  AuthError.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    email_1 = json['email_1'];
    email_2 = json['email_2'];
    email_3 = json['email_3'];

    mobile = json['mobile'];
    mobile_1 = json['mobile_1'];
    mobile_2 = json['mobile_2'];
    mobile_3 = json['mobile_3'];
    emirate_image1 = json['emirate_image1'];
    emirate_image2 = json['emirate_image2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['email_1'] = this.email_1;
    data['email_2'] = this.email_2;
    data['email_3'] = this.email_3;
    data['email_3'] = this.email_3;
    data['email_3'] = this.email_3;
    data['emirate_image1'] = this.emirate_image1;
    data['emirate_image2'] = this.emirate_image2;

    data['mobile'] = this.mobile;
    data['mobile_1'] = this.mobile_1;
    data['mobile_2'] = this.mobile_2;
    data['mobile_3'] = this.mobile_3;

    return data;
  }
}
