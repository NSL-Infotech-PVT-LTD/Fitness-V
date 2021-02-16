
class NotificationList {
  NotificationList({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.body,
    this.message,
    this.targetId,
    this.createdBy,
    this.isRead,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.bookingDetail,
    this.customerDetail,
  });

  int id;
  Title title;
  String body;
  Message message;
  int targetId;
  int createdBy;
  String isRead;
  dynamic params;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  BookingDetail bookingDetail;
  CustomerDetail customerDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: titleValues.map[json["title"]],
    body:json["body"],
    message: messageValues.map[json["message"]],
    targetId: json["target_id"],
    createdBy: json["created_by"],
    isRead: json["is_read"],
    params: json["params"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
    customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "body": body,
    "message": messageValues.reverse[message],
    "target_id": targetId,
    "created_by": createdBy,
    "is_read": isRead,
    "params": params,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "booking_detail": bookingDetail.toJson(),
    "customer_detail": customerDetail.toJson(),
  };
}



class BookingDetail {
  BookingDetail({
    this.targetModel,
    this.dataType,
  });

  DataType targetModel;
  DataType dataType;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    targetModel: dataTypeValues.map[json["target_model"]],
    dataType: dataTypeValues.map[json["data_type"]],
  );

  Map<String, dynamic> toJson() => {
    "target_model": dataTypeValues.reverse[targetModel],
    "data_type": dataTypeValues.reverse[dataType],
  };
}

enum DataType { BOOKING }

final dataTypeValues = EnumValues({
  "Booking": DataType.BOOKING
});

class CustomerDetail {
  CustomerDetail({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.image,
    this.role,
    this.fullName,
  });

  int id;
  FirstName firstName;
  MiddleName middleName;
  LastName lastName;
  Image image;
  Role role;
  FullName fullName;

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    id: json["id"],
    firstName: firstNameValues.map[json["first_name"]],
    middleName: middleNameValues.map[json["middle_name"]],
    lastName: lastNameValues.map[json["last_name"]],
    image: imageValues.map[json["image"]],
    role: Role.fromJson(json["role"]),
    fullName: fullNameValues.map[json["full_name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstNameValues.reverse[firstName],
    "middle_name": middleNameValues.reverse[middleName],
    "last_name": lastNameValues.reverse[lastName],
    "image": imageValues.reverse[image],
    "role": role.toJson(),
    "full_name": fullNameValues.reverse[fullName],
  };
}

enum FirstName { JUGRAJ }

final firstNameValues = EnumValues({
  "jugraj": FirstName.JUGRAJ
});

enum FullName { JUGRAJ_ABC_SINGH }

final fullNameValues = EnumValues({
  "jugraj abc singh": FullName.JUGRAJ_ABC_SINGH
});

enum Image { THE_1602764393_JPG }

final imageValues = EnumValues({
  "1602764393.jpg": Image.THE_1602764393_JPG
});

enum LastName { SINGH }

final lastNameValues = EnumValues({
  "singh": LastName.SINGH
});

enum MiddleName { ABC }

final middleNameValues = EnumValues({
  "abc": MiddleName.ABC
});

class Role {
  Role({
    this.name,
    this.id,
    this.image,
    this.category,
    // this.plans,
    this.priceLabelMonthly,
    this.priceLabelQuarterly,
    this.priceLabelHalfYearly,
    this.priceLabelYearly,
    this.permission,
    this.currentPlan,
    this.actionDate,
  });

  Name name;
  int id;
  dynamic image;
  dynamic category;
  // List<dynamic> plans;
  String priceLabelMonthly;
  String priceLabelQuarterly;
  String priceLabelHalfYearly;
  String priceLabelYearly;
  List<dynamic> permission;
  dynamic currentPlan;
  DateTime actionDate;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    name: nameValues.map[json["name"]],
    id: json["id"],
    image: json["image"],
    category: json["category"],
    // plans: List<dynamic>.from(json["plans"].map((x) => x)),
    priceLabelMonthly: json["price_label_monthly"],
    priceLabelQuarterly: json["price_label_quarterly"],
    priceLabelHalfYearly: json["price_label_half_yearly"],
    priceLabelYearly: json["price_label_yearly"],
    permission: List<dynamic>.from(json["permission"].map((x) => x)),
    currentPlan: json["current_plan"],
    actionDate: DateTime.parse(json["action_date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "id": id,
    "image": image,
    "category": category,
    // "plans": List<dynamic>.from(plans.map((x) => x)),
    "price_label_monthly": priceLabelMonthly,
    "price_label_quarterly": priceLabelQuarterly,
    "price_label_half_yearly": priceLabelHalfYearly,
    "price_label_yearly": priceLabelYearly,
    "permission": List<dynamic>.from(permission.map((x) => x)),
    "current_plan": currentPlan,
    "action_date": actionDate.toIso8601String(),
  };
}

enum Name { LOCAL_GUEST }

final nameValues = EnumValues({
  "Local Guest": Name.LOCAL_GUEST
});

enum Message { TARGET_ID_1_TARGET_MODEL_BOOKING_DATA_TYPE_BOOKING }

final messageValues = EnumValues({
  "{\"target_id\":1,\"target_model\":\"Booking\",\"data_type\":\"Booking\"}": Message.TARGET_ID_1_TARGET_MODEL_BOOKING_DATA_TYPE_BOOKING
});

enum Title { CONFIRMED }

final titleValues = EnumValues({
  "Confirmed": Title.CONFIRMED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
