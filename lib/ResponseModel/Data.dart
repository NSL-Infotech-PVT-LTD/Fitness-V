import 'package:volt/ResponseModel/UserResponse.dart';

class Data {
  String message;
  String token;
  int current_page;
  UserResponse user;
  UserResponse trainer;
  List<dynamic> data;
  List<dynamic> gym_members;

  List<dynamic> pool_and_beach_members;
  List<dynamic> local_guest;
  List<dynamic> fairmont_hotel_guest;

//  e user;

  Data(
      {this.token,
      this.message,
      this.current_page,
      this.user,
      this.trainer,
      this.gym_members,
      this.pool_and_beach_members,
      this.local_guest,
      this.fairmont_hotel_guest});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    current_page = json['current_page'];
    user =
        json['user'] != null ? new UserResponse.fromJson(json['user']) : null;
    trainer = json['trainer'] != null
        ? new UserResponse.fromJson(json['trainer'])
        : null;
    data = json['data'] != null ? json['data'] : null;
    gym_members = json['gym_members'] != null ? json['gym_members'] : null;
    pool_and_beach_members = json['pool_and_beach_members'] != null
        ? json['pool_and_beach_members']
        : null;
    local_guest = json['local_guest'] != null ? json['local_guest'] : null;
    fairmont_hotel_guest = json['fairmont_hotel_guest'] != null
        ? json['fairmont_hotel_guest']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['current_page'] = this.current_page;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.trainer != null) {
      data['trainer'] = this.trainer.toJson();
    }

    if (this.data != null) {
      data['data'] = this.data;
    }
    if (this.gym_members != null) {
      data['gym_members'] = this.gym_members;
    }

    if (this.pool_and_beach_members != null) {
      data['pool_and_beach_members'] = this.pool_and_beach_members;
    }

    if (this.local_guest != null) {
      data['local_guest'] = this.local_guest;
    }

    if (this.gym_members != null) {
      data['fairmont_hotel_guest'] = this.fairmont_hotel_guest;
    }
  }
}
