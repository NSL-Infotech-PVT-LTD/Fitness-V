import 'package:volt/ResponseModel/PleanDetail.dart';

class UserResponse {
  int id;
  int booking_cnt;
  int booking_reviewed_cnt;
  String rating_avg;
  String full_name;
  String first_name;
  String middle_name;
  String last_name;
  String category;
  String image;
  String params;
  String about;
  String services;
  String status;
  String deleted_at;
  String created_at;
  String updated_at;
  List<PlanDetail> plan_detail;
  UserResponse(
    this.id,
    this.booking_cnt,
    this.booking_reviewed_cnt,
    this.rating_avg,
    this.full_name,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.category,
    this.image,
    this.params,
    this.about,
    this.services,
    this.status,
    this.deleted_at,
    this.created_at,
    this.updated_at,
    this.plan_detail,
  );

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    booking_reviewed_cnt = json['booking_reviewed_cnt'];
    booking_cnt = json['booking_cnt'];
    rating_avg = json['rating_avg'];
    full_name = json['full_name'];
    first_name = json['first_name'];
    middle_name = json['middle_name'];
    last_name = json['last_name'];
    category = json['category'];
    image = json['image'];
    params = json['params'];
    about = json['about'];
    services = json['services'];
    status = json['status'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    plan_detail = json['plan_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_reviewed_cnt'] = this.booking_reviewed_cnt;
    data['rating_avg'] = this.rating_avg;
    data['booking_cnt'] = this.booking_cnt;
    data['full_name'] = this.full_name;
    data['first_name'] = this.first_name;
    data['middle_name'] = this.middle_name;
    data['last_name'] = this.last_name;
    data['category'] = this.category;
    data['image'] = this.image;
    data['about'] = this.about;
    data['services'] = this.services;
    data['params'] = this.params;
    data['status'] = this.status;
    data['deleted_at'] = this.deleted_at;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['plan_detail'] = this.plan_detail;
  }
}
