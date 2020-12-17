import 'package:volt/ResponseModel/UserResponse.dart';

class CreatedByModel {
  String image;
  String name;
  String full_name;
  int id;

  UserResponse class_detail;

  CreatedByModel(this.image,
      this.id,
      this.name,
      this.full_name,
      this.class_detail,);

  CreatedByModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
    full_name = json['full_name'];
    class_detail =
    json['class_detail'] != null ? new UserResponse.fromJson(
        json['class_detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    data['name'] = this.name;
    if (data[class_detail] != null) {
      data["class_detail"] = this.class_detail;
    }
    data['full_name'] = this.full_name;
  }
}
