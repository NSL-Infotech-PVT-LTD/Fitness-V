class CreatedByModel {
  String image;
  String name;
  String full_name;
  int id;

  CreatedByModel(
    this.image,
    this.id,
    this.name,
    this.full_name,
  );

  CreatedByModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
    full_name = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_name'] = this.full_name;
  }
}
