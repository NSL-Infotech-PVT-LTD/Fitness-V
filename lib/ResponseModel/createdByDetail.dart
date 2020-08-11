class CreatedByModel {
  String image;

  CreatedByModel(
    this.image,
  );

  CreatedByModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
  }
}
