import 'package:volt/ResponseModel/UserResponse.dart';

class Data {
  String message;
  String token;
  int id;
  int last_page;
  String name;
  String config;
  String image;
  String description;
  int current_page;
  String start_date;
  String end_date;
  UserResponse user;
  UserResponse location_detail;
  UserResponse trainer;
  List<dynamic> data;
  List<dynamic> related;
  List<dynamic> gym_members;

  List<dynamic> pool_and_beach_members;
  List<dynamic> local_guest;
  List<dynamic> fairmont_hotel_guest;

//  e user;

  Data(
      {this.token,
      this.message,
      this.id,
      this.last_page,
      this.name,
      this.config,
      this.image,
      this.description,
      this.start_date,
      this.end_date,
      this.current_page,
      this.user,
      this.trainer,
      this.location_detail,
      this.gym_members,
      this.pool_and_beach_members,
      this.related,
      this.local_guest,
      this.fairmont_hotel_guest});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    name = json['name'];
    config = json['config'];
    description = json['description'];
    image = json['image'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    id = json['id'];
    last_page = json['last_page'];
    current_page = json['current_page'];
    user =
        json['user'] != null ? new UserResponse.fromJson(json['user']) : null;
    trainer = json['trainer'] != null
        ? new UserResponse.fromJson(json['trainer'])
        : null;

    location_detail = json['location_detail'] != null
        ? new UserResponse.fromJson(json['location_detail'])
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
    related = json['related'] != null
        ? json['related']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['last_page'] = this.last_page;
    data['name'] = this.name;
    data['config'] = this.config;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['description'] = this.description;
    data['image'] = this.image;
    data['current_page'] = this.current_page;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.trainer != null) {
      data['trainer'] = this.trainer.toJson();
    }
    if (this.location_detail != null) {
      data['location_detail'] = this.location_detail.toJson();
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

    if (this.fairmont_hotel_guest != null) {
      data['fairmont_hotel_guest'] = this.fairmont_hotel_guest;
    }
    if (this.related != null) {
      data['related'] = this.related;
    }
  }
}
