class RoleModel {
  String name;

  RoleModel(
    this.name,
  );

  RoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
  }
}
