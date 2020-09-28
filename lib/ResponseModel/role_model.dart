import 'currentPlan.dart';

class RoleModel {
  String name;
  String category;
  String image;
  CurrentPlan current_plan;

  RoleModel(
    this.name,
    this.category,
    this.current_plan,
    this.image,
  );

  RoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    category = json['category'];
    current_plan = json['current_plan'] != null
        ? new CurrentPlan.fromJson(json['current_plan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['image'] = this.image;
    data['category'] = this.category;
    if (this.current_plan != null) {
      data['current_plan'] = this.current_plan;
    }
  }
}
