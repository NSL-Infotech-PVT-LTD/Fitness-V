import 'currentPlan.dart';

class RoleModel {
  String name;
  int id;
  String category;
  String nameFilter;
  String image;
  CurrentPlan current_plan;

  RoleModel(
    this.name,
    this.category,
    this.current_plan,
    this.image,
    this.id,
    this.nameFilter
  );

  RoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameFilter = json['name_filter'];
    image = json['image'];
    id = json['id'];
    category = json['category'];
    current_plan = json['current_plan'] != null
        ? new CurrentPlan.fromJson(json['current_plan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['id'] = this.id;
    data['name_filter'] = this.nameFilter;
    data['image'] = this.image;
    data['category'] = this.category;
    if (this.current_plan != null) {
      data['current_plan'] = this.current_plan;
    }
  }
}
