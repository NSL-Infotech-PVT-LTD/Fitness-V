class PlanDetail {
  int id;
  int fee;
  String fee_type;
  int role_id;
  String role_plan;

  PlanDetail(this.id, this.fee, this.fee_type, this.role_id, this.role_plan);

  PlanDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    fee_type = json['fee_type'];
    role_id = json['role_id'];
    role_plan = json['role_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['fee_type'] = this.fee_type;
    data['role_id'] = this.role_id;
    data['role_plan'] = this.role_plan;
  }
}
