
class HaveChildData {
    HaveChildData({
        this.status,
        this.code,
        this.data,
    });

    bool status;
    int code;
    List<Data> data;

    factory HaveChildData.fromJson(Map<String, dynamic> json) => HaveChildData(
        status: json["status"],
        code: json["code"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.label,
        this.type,
        this.category,
        this.image,
        this.params,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.plans,
        this.planDetail,
    });

    int id;
    String name;
    String label;
    String type;
    String category;
    dynamic image;
    dynamic params;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    Plans plans;
    List<PlanDetail> planDetail;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        label: json["label"],
        type: json["type"],
        category: json["category"],
        image: json["image"],
        params: json["params"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        plans: Plans.fromJson(json["plans"]),
        planDetail: List<PlanDetail>.from(json["plan_detail"].map((x) => PlanDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "label": label,
        "type": type,
        "category": category,
        "image": image,
        "params": params,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "plans": plans.toJson(),
        "plan_detail": List<dynamic>.from(planDetail.map((x) => x.toJson())),
    };
}

class PlanDetail {
    PlanDetail({
        this.id,
        this.fee,
        this.feeType,
        this.roleId,
        this.rolePlan,
    });

    int id;
    int fee;
    String feeType;
    int roleId;
    String rolePlan;

    factory PlanDetail.fromJson(Map<String, dynamic> json) => PlanDetail(
        id: json["id"],
        fee: json["fee"],
        feeType: json["fee_type"],
        roleId: json["role_id"],
        rolePlan: json["role_plan"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fee": fee,
        "fee_type": feeType,
        "role_id": roleId,
        "role_plan": rolePlan,
    };
}

class Plans {
    Plans({
        this.monthly,
        this.quarterly,
        this.halfYearly,
        this.yearly,
    });

    Time monthly;
    Time quarterly;
    Time halfYearly;
    Time yearly;

    factory Plans.fromJson(Map<String, dynamic> json) => Plans(
        monthly: Time.fromJson(json["monthly"]),
        quarterly: Time.fromJson(json["quarterly"]),
        halfYearly: Time.fromJson(json["half_yearly"]),
        yearly: Time.fromJson(json["yearly"]),
    );

    Map<String, dynamic> toJson() => {
        "monthly": monthly.toJson(),
        "quarterly": quarterly.toJson(),
        "half_yearly": halfYearly.toJson(),
        "yearly": yearly.toJson(),
    };
}

class Time {
    Time({
        this.id,
        this.fee,
    });

    int id;
    int fee;

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        fee: json["fee"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fee": fee,
    };
}
