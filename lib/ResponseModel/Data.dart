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
  String class_type;
  String capacity;
  int available_capacity;
  String duration;
  bool is_booked_by_me;
  UserResponse user;
  UserResponse location_detail;
  UserResponse model_detail;
  UserResponse trainer;
  UserResponse booking;
  UserResponse class_detail;
  List<dynamic> data;
  List<dynamic> related;
  List<dynamic> gym_members;

  List<dynamic> pool_and_beach_members;
  List<dynamic> local_guest;
  List<dynamic> fairmont_hotel_guest;

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
      this.class_type,
      this.capacity,
      this.available_capacity,
      this.duration,
      this.current_page,
      this.user,
      this.trainer,
      this.location_detail,
      this.gym_members,
      this.pool_and_beach_members,
      this.model_detail,
      this.related,
      this.is_booked_by_me,
      this.booking,
      this.class_detail,
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
    class_type = json['class_type'];
    capacity = json['capacity'];
    available_capacity = json['available_capacity'];
    duration = json['duration'];
    id = json['id'];
    last_page = json['last_page'];
    is_booked_by_me = json['is_booked_by_me'];
    current_page = json['current_page'];
    user =
        json['user'] != null ? new UserResponse.fromJson(json['user']) : null;
    booking = json['booking'] != null
        ? new UserResponse.fromJson(json['booking'])
        : null;
    class_detail = json['class_detail'] != null
        ? new UserResponse.fromJson(json['class_detail'])
        : null;
    trainer = json['trainer'] != null
        ? new UserResponse.fromJson(json['trainer'])
        : null;

    location_detail = json['location_detail'] != null
        ? new UserResponse.fromJson(json['location_detail'])
        : null;
    data = json['data'] != null ? json['data'] : null;
    model_detail = json['model_detail'] != null ? json['model_detail'] : null;
    gym_members = json['gym_members'] != null ? json['gym_members'] : null;
    pool_and_beach_members = json['pool_and_beach_members'] != null
        ? json['pool_and_beach_members']
        : null;
    local_guest = json['local_guest'] != null ? json['local_guest'] : null;
    fairmont_hotel_guest = json['fairmont_hotel_guest'] != null
        ? json['fairmont_hotel_guest']
        : null;
    related = json['related'] != null ? json['related'] : null;
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
    data['class_type'] = this.class_type;
    data['capacity'] = this.capacity;
    data['available_capacity'] = this.available_capacity;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['image'] = this.image;
    data['current_page'] = this.current_page;
    data['token'] = this.token;
    data['is_booked_by_me'] = this.is_booked_by_me;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking.toJson();
    }
    if (this.trainer != null) {
      data['trainer'] = this.trainer.toJson();
    }
    if (this.model_detail != null) {
      data['model_detail'] = this.model_detail.toJson();
    }
    if (this.location_detail != null) {
      data['location_detail'] = this.location_detail.toJson();
    }

    if (this.data != null) {
      data['data'] = this.data;
    }
    if (this.class_detail != null) {
      data['class_detail'] = this.class_detail;
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
