class gymMember {
  bool status;
  int code;
  List<Data> data;

  gymMember({this.status, this.code, this.data});

  gymMember.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String label;
  String type;
  String category;
  int member;
  String image;
  String params;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Plans plans;
  String priceLabelMonthly;
  String priceLabelQuarterly;
  String priceLabelHalfYearly;
  String priceLabelYearly;
  List<PlanDetail> planDetail;

  Data(
      {this.id,
        this.name,
        this.label,
        this.type,
        this.category,
        this.member,
        this.image,
        this.params,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.plans,
        this.priceLabelMonthly,
        this.priceLabelQuarterly,
        this.priceLabelHalfYearly,
        this.priceLabelYearly,
        this.planDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    type = json['type'];
    category = json['category'];
    member = json['member'];
    image = json['image'] != null?json['image']:"";
    params = json['params'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    plans = json['plans'] != null ? new Plans.fromJson(json['plans']) : null;
    priceLabelMonthly = json['price_label_monthly'];
    priceLabelQuarterly = json['price_label_quarterly'];
    priceLabelHalfYearly = json['price_label_half_yearly'];
    priceLabelYearly = json['price_label_yearly'];
    if (json['plan_detail'] != null) {
      planDetail = new List<PlanDetail>();
      json['plan_detail'].forEach((v) {
        planDetail.add(new PlanDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['label'] = this.label;
    data['type'] = this.type;
    data['category'] = this.category;
    data['member'] = this.member;
    data['image'] = this.image;
    data['params'] = this.params;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.plans != null) {
      data['plans'] = this.plans.toJson();
    }
    data['price_label_monthly'] = this.priceLabelMonthly;
    data['price_label_quarterly'] = this.priceLabelQuarterly;
    data['price_label_half_yearly'] = this.priceLabelHalfYearly;
    data['price_label_yearly'] = this.priceLabelYearly;
    if (this.planDetail != null) {
      data['plan_detail'] = this.planDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  Monthly monthly;
  Monthly quarterly;
  Monthly halfYearly;
  Monthly yearly;

  Plans({this.monthly, this.quarterly, this.halfYearly, this.yearly});

  Plans.fromJson(Map<String, dynamic> json) {
    monthly =
    json['monthly'] != null ? new Monthly.fromJson(json['monthly']) : null;
    quarterly = json['quarterly'] != null
        ? new Monthly.fromJson(json['quarterly'])
        : null;
    halfYearly = json['half_yearly'] != null
        ? new Monthly.fromJson(json['half_yearly'])
        : null;
    yearly =
    json['yearly'] != null ? new Monthly.fromJson(json['yearly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthly != null) {
      data['monthly'] = this.monthly.toJson();
    }
    if (this.quarterly != null) {
      data['quarterly'] = this.quarterly.toJson();
    }
    if (this.halfYearly != null) {
      data['half_yearly'] = this.halfYearly.toJson();
    }
    if (this.yearly != null) {
      data['yearly'] = this.yearly.toJson();
    }
    return data;
  }
}

class Monthly {
  int id;
  int fee;
  String feeType;

  Monthly({this.id, this.fee, this.feeType});

  Monthly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    feeType = json['fee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['fee_type'] = this.feeType;
    return data;
  }
}

class PlanDetail {
  int id;
  int fee;
  String feeType;
  int roleId;
  String rolePlan;

  PlanDetail({this.id, this.fee, this.feeType, this.roleId, this.rolePlan});

  PlanDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    feeType = json['fee_type'];
    roleId = json['role_id'];
    rolePlan = json['role_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['fee_type'] = this.feeType;
    data['role_id'] = this.roleId;
    data['role_plan'] = this.rolePlan;
    return data;
  }
}
