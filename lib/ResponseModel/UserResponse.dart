import 'package:volt/ResponseModel/PleanDetail.dart';
import 'package:volt/ResponseModel/createdByDetail.dart';
import 'package:volt/ResponseModel/role_model.dart';

class UserResponse {
  int id;
  String name;
  String model_type;
  String review;
  int rating;
  String location;
  int booking_cnt;
  int booking_reviewed_cnt;
  String rating_avg;
  String expirence;
  String full_name;
  String first_name;
  String middle_name;
  String last_name;
  String mobile;
  String emergency_contact_no;
  String emirates_id;
  String address;
  String email;
  String designation;
  String category;
  String image;
  String description;
  String params;
  String about;
  String services;
  String status;
  String deleted_at;
  String created_at;
  String hours;
  String updated_at;
  String birth_date;
  String specialities;
  String certifications;
  bool is_booked_by_me;
  CreatedByModel created_by_detail;
  RoleModel role;
  CreatedByModel model_detail;
  CreatedByModel class_detail;
  List<PlanDetail> plan_detail;
  UserResponse(
    this.id,
    this.name,
    this.model_type,
    this.location,
    this.booking_cnt,
    this.booking_reviewed_cnt,
    this.rating_avg,
    this.full_name,
    this.first_name,
    this.expirence,
    this.mobile,
    this.emergency_contact_no,
    this.email,
    this.designation,
    this.emirates_id,
    this.address,
    this.middle_name,
    this.last_name,
    this.category,
    this.image,
    this.params,
    this.about,
    this.services,
    this.status,
    this.description,
    this.deleted_at,
    this.created_at,
    this.updated_at,
    this.plan_detail,
    this.created_by_detail,
    this.class_detail,
    this.model_detail,
    this.birth_date,
    this.role,
    this.hours,
    this.certifications,
    this.specialities,
    this.is_booked_by_me,
  );

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    certifications = json['certifications'];
    specialities = json['specialities'];
    model_type = json['model_type'];
    location = json['location'];
    expirence = json['expirence'];
    booking_reviewed_cnt = json['booking_reviewed_cnt'];
    booking_cnt = json['booking_cnt'];
    rating_avg = json['rating_avg'];
    full_name = json['full_name'];
    first_name = json['first_name'];
    mobile = json['mobile'];
    emergency_contact_no = json['emergency_contact_no'];
    email = json['email'];
    designation = json['designation'];
    emirates_id = json['emirates_id'];
    address = json['address'];
    middle_name = json['middle_name'];
    last_name = json['last_name'];
    category = json['category'];
    description = json['description'];
    image = json['image'];
    params = json['params'];
    about = json['about'];
    services = json['services'];
    status = json['status'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    hours = json['hours'];
    birth_date = json['birth_date'];
    is_booked_by_me = json['is_booked_by_me'];
    created_by_detail = json['created_by_detail'] != null ? new CreatedByModel.fromJson(json['created_by_detail']) : null;
    class_detail = json['class_detail'] != null ? new CreatedByModel.fromJson(json['class_detail']) : null;
    role = json['role'] != null ? new RoleModel.fromJson(json['role']) : null;
    model_detail = json['model_detail'] != null ? new CreatedByModel.fromJson(json['model_detail']) : null;
    plan_detail = json['plan_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.model_type;
    data['name'] = this.name;
    data['hours'] = this.hours;
    data['location'] = this.location;
    data['description'] = this.description;
    data['expirence'] = this.expirence;
    data['booking_reviewed_cnt'] = this.booking_reviewed_cnt;
    data['rating_avg'] = this.rating_avg;
    data['booking_cnt'] = this.booking_cnt;
    data['full_name'] = this.full_name;
    data['first_name'] = this.first_name;
    data['mobile'] = this.mobile;
    data['emergency_contact_no'] = this.emergency_contact_no;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['emirates_id'] = this.emirates_id;
    data['address'] = this.address;
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
    data['birth_date'] = this.birth_date;
    data['plan_detail'] = this.plan_detail;
    data['is_booked_by_me'] = this.is_booked_by_me;
    data['specialities'] = this.specialities;
    data['certifications'] = this.certifications;

    if (this.created_by_detail != null) {
      data['created_by_detail'] = this.created_by_detail.toJson();
    } if (this.class_detail != null) {
      data['class_detail'] = this.class_detail.toJson();
    }if (this.model_detail != null) {
      data['model_detail'] = this.model_detail.toJson();
    }if (this.role != null) {
      data['role'] = this.role.toJson();
    }
  }
}
