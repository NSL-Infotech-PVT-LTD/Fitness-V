// class gymMember {
//   gymMember({
//     this.status,
//     this.code,
//     this.data,
//   });
//
//   bool status;
//   int code;
//   Data data;
//
//   factory gymMember.fromJson(Map<String, dynamic> json) => gymMember(
//     status: json["status"],
//     code: json["code"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "code": code,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.gymMembers,
//     this.poolAndBeachMembers,
//     this.localGuest,
//     this.fairmontHotelGuest,
//   });
//
//   List<Member> gymMembers;
//   List<Member> poolAndBeachMembers;
//   List<LGuest> localGuest;
//   List<LGuest> fairmontHotelGuest;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     gymMembers: List<Member>.from(json["gym_members"].map((x) => Member.fromJson(x))),
//     poolAndBeachMembers: List<Member>.from(json["pool_and_beach_members"].map((x) => Member.fromJson(x))),
//     localGuest: List<LGuest>.from(json["local_guest"].map((x) => LGuest.fromJson(x))),
//     fairmontHotelGuest: List<LGuest>.from(json["fairmont_hotel_guest"].map((x) => LGuest.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "gym_members": List<dynamic>.from(gymMembers.map((x) => x.toJson())),
//     "pool_and_beach_members": List<dynamic>.from(poolAndBeachMembers.map((x) => x.toJson())),
//     "local_guest": List<dynamic>.from(localGuest.map((x) => x.toJson())),
//     "fairmont_hotel_guest": List<dynamic>.from(fairmontHotelGuest.map((x) => x.toJson())),
//   };
// }
//
// class LGuest {
//   LGuest({
//     this.id,
//     this.name,
//     this.label,
//     this.type,
//     this.category,
//     this.member,
//     this.image,
//     this.params,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.plans,
//     this.priceLabelMonthly,
//     this.priceLabelQuarterly,
//     this.priceLabelHalfYearly,
//     this.priceLabelYearly,
//     this.planDetail,
//   });
//
//   int id;
//   String name;
//   String label;
//   String type;
//   dynamic category;
//   dynamic member;
//   dynamic image;
//   dynamic params;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic deletedAt;
//   List<dynamic> plans;
//   String priceLabelMonthly;
//   String priceLabelQuarterly;
//   String priceLabelHalfYearly;
//   String priceLabelYearly;
//   List<dynamic> planDetail;
//
//   factory LGuest.fromJson(Map<String, dynamic> json) => LGuest(
//     id: json["id"],
//     name: json["name"],
//     label: json["label"],
//     type: json["type"],
//     category: json["category"],
//     member: json["member"],
//     image: json["image"],
//     params: json["params"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     plans: List<dynamic>.from(json["plans"].map((x) => x)),
//     priceLabelMonthly: json["price_label_monthly"],
//     priceLabelQuarterly: json["price_label_quarterly"],
//     priceLabelHalfYearly: json["price_label_half_yearly"],
//     priceLabelYearly: json["price_label_yearly"],
//     planDetail: List<dynamic>.from(json["plan_detail"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "label": label,
//     "type": type,
//     "category": category,
//     "member": member,
//     "image": image,
//     "params": params,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "deleted_at": deletedAt,
//     "plans": List<dynamic>.from(plans.map((x) => x)),
//     "price_label_monthly": priceLabelMonthly,
//     "price_label_quarterly": priceLabelQuarterly,
//     "price_label_half_yearly": priceLabelHalfYearly,
//     "price_label_yearly": priceLabelYearly,
//     "plan_detail": List<dynamic>.from(planDetail.map((x) => x)),
//   };
// }
//
// class Member {
//   Member({
//     this.id,
//     this.name,
//     this.label,
//     this.type,
//     this.category,
//     this.member,
//     this.image,
//     this.params,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.plans,
//     this.priceLabelMonthly,
//     this.priceLabelQuarterly,
//     this.priceLabelHalfYearly,
//     this.priceLabelYearly,
//     this.planDetail,
//   });
//
//   int id;
//   String name;
//   String label;
//   String type;
//   String category;
//   int member;
//   String image;
//   dynamic params;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic deletedAt;
//   Plans plans;
//   String priceLabelMonthly;
//   String priceLabelQuarterly;
//   String priceLabelHalfYearly;
//   String priceLabelYearly;
//   List<PlanDetail> planDetail;
//
//   factory Member.fromJson(Map<String, dynamic> json) => Member(
//     id: json["id"],
//     name: json["name"],
//     label: json["label"],
//     type: json["type"],
//     category: json["category"],
//     member: json["member"],
//     image: json["image"] == null ? null : json["image"],
//     params: json["params"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     plans: Plans.fromJson(json["plans"]),
//     priceLabelMonthly: json["price_label_monthly"],
//     priceLabelQuarterly: json["price_label_quarterly"],
//     priceLabelHalfYearly: json["price_label_half_yearly"],
//     priceLabelYearly: json["price_label_yearly"],
//     planDetail: List<PlanDetail>.from(json["plan_detail"].map((x) => PlanDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "label": label,
//     "type": type,
//     "category": category,
//     "member": member,
//     "image": image == null ? null : image,
//     "params": params,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "deleted_at": deletedAt,
//     "plans": plans.toJson(),
//     "price_label_monthly": priceLabelMonthly,
//     "price_label_quarterly": priceLabelQuarterly,
//     "price_label_half_yearly": priceLabelHalfYearly,
//     "price_label_yearly": priceLabelYearly,
//     "plan_detail": List<dynamic>.from(planDetail.map((x) => x.toJson())),
//   };
// }
//
// class PlanDetail {
//   PlanDetail({
//     this.id,
//     this.fee,
//     this.feeType,
//     this.roleId,
//     this.rolePlan,
//   });
//
//   int id;
//   int fee;
//   FeeType feeType;
//   int roleId;
//   String rolePlan;
//
//   factory PlanDetail.fromJson(Map<String, dynamic> json) => PlanDetail(
//     id: json["id"],
//     fee: json["fee"],
//     feeType: feeTypeValues.map[json["fee_type"]],
//     roleId: json["role_id"],
//     rolePlan: json["role_plan"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "fee": fee,
//     "fee_type": feeTypeValues.reverse[feeType],
//     "role_id": roleId,
//     "role_plan": rolePlan,
//   };
// }
//
// enum FeeType { HALF_YEARLY, QUARTERLY, YEARLY }
//
// final feeTypeValues = EnumValues({
//   "half_yearly": FeeType.HALF_YEARLY,
//   "quarterly": FeeType.QUARTERLY,
//   "yearly": FeeType.YEARLY
// });
//
// class Plans {
//   Plans({
//     this.quarterly,
//     this.halfYearly,
//     this.yearly,
//   });
//
//   Rly quarterly;
//   Rly halfYearly;
//   Rly yearly;
//
//   factory Plans.fromJson(Map<String, dynamic> json) => Plans(
//     quarterly: Rly.fromJson(json["quarterly"]),
//     halfYearly: Rly.fromJson(json["half_yearly"]),
//     yearly: Rly.fromJson(json["yearly"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "quarterly": quarterly.toJson(),
//     "half_yearly": halfYearly.toJson(),
//     "yearly": yearly.toJson(),
//   };
// }
//
// class Rly {
//   Rly({
//     this.id,
//     this.fee,
//     this.feeType,
//   });
//
//   int id;
//   int fee;
//   FeeType feeType;
//
//   factory Rly.fromJson(Map<String, dynamic> json) => Rly(
//     id: json["id"],
//     fee: json["fee"],
//     feeType: feeTypeValues.map[json["fee_type"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "fee": fee,
//     "fee_type": feeTypeValues.reverse[feeType],
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
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
  Null params;
  String status;
  String createdAt;
  String updatedAt;
  Null deletedAt;
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
    image = json['image'];
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
  Quarterly quarterly;
  Quarterly halfYearly;
  Quarterly yearly;

  Plans({this.quarterly, this.halfYearly, this.yearly});

  Plans.fromJson(Map<String, dynamic> json) {
    quarterly = json['quarterly'] != null
        ? new Quarterly.fromJson(json['quarterly'])
        : null;
    halfYearly = json['half_yearly'] != null
        ? new Quarterly.fromJson(json['half_yearly'])
        : null;
    yearly =
    json['yearly'] != null ? new Quarterly.fromJson(json['yearly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Quarterly {
  int id;
  int fee;
  String feeType;
  int roleId;

  Quarterly({this.id, this.fee, this.feeType, this.roleId});

  Quarterly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    feeType = json['fee_type'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['fee_type'] = this.feeType;
    data['role_id'] = this.roleId;
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
