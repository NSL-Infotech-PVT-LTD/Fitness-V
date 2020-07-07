
class UserResponse {
  int id;
  String first_name;
  String last_name;
  String gender;
  String email;
  String email_verified_at;
  String image;
  String address;
  String mobile;
  String national_id;
  String status;
  String password_decrypt;
  String fullname;
  String created_at;
  String updated_at;



  UserResponse(
      this.id,
      this.first_name,
      this.last_name,
      this.gender,
      this.email,
      this.email_verified_at,
      this.image,
      this.address,
      this.mobile,
      this.national_id,
      this.status,
      this.password_decrypt,
      this.fullname,
      this.created_at,
      this.updated_at,
      );

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    gender = json['gender'];
    email = json['email'];
    email_verified_at = json['email_verified_at'];
    image = json['image'];
    address = json['address'];
    mobile = json['mobile'];
    national_id = json['national_id'];
    status = json['status'];
    password_decrypt = json['password_decrypt'];
    fullname = json['fullname'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>() ;
    data['id'] = this.id;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['email_verified_at'] = this.email_verified_at;
    data['image'] = this.image;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['national_id'] = this.national_id;
    data['status'] = this.status;
    data['password_decrypt'] = this.password_decrypt;
    data['fullname'] = this.fullname;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;

  }
}
