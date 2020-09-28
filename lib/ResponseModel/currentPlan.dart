class CurrentPlan {
  int id;
  String fee_type;
  int fee;
  String role_plan;

  CurrentPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee_type = json['fee_type'];
    fee = json['fee'];
    role_plan = json['role_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['fee_type'] = this.fee_type;
    data['fee'] = this.fee;
    data['role_plan'] = this.role_plan;
  }
}
