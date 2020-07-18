import 'package:volt/ResponseModel/PleanDetail.dart';

class UserResponse {
  int id;
  String name;
  String label;
  String type;
  String category;
  String image;
  String params;
  String status;
  String deleted_at;
  String created_at;
  String updated_at;
  List<PlanDetail> plan_detail;
  UserResponse(
    this.id,
    this.name,
    this.label,
    this.type,
    this.category,
    this.image,
    this.params,
    this.status,
    this.deleted_at,
    this.created_at,
    this.updated_at,
    this.plan_detail,
  );

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    type = json['type'];
    category = json['category'];
    image = json['image'];
    params = json['params'];
    status = json['status'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    plan_detail = json['plan_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['label'] = this.label;
    data['type'] = this.type;
    data['category'] = this.category;
    data['image'] = this.image;
    data['params'] = this.params;
    data['status'] = this.status;
    data['deleted_at'] = this.deleted_at;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['plan_detail'] = this.plan_detail;
  }
}
