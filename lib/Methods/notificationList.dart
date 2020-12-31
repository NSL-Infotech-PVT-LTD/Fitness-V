class NotificationList {
  bool status;
  int code;
  Data data;

  NotificationList({this.status, this.code, this.data});

  NotificationList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Data(
      {this.currentPage,
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
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int id;
  String title;
  String body;
  String message;
  int targetId;
  int createdBy;
  String isRead;
  Null params;
  String status;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  BookingDetail bookingDetail;
  CustomerDetail customerDetail;

  Data(
      {this.id,
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
        this.customerDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    message = json['message'];
    targetId = json['target_id'];
    createdBy = json['created_by'];
    isRead = json['is_read'];
    params = json['params'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    bookingDetail = json['booking_detail'] != null
        ? new BookingDetail.fromJson(json['booking_detail'])
        : null;
    customerDetail = json['customer_detail'] != null
        ? new CustomerDetail.fromJson(json['customer_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['message'] = this.message;
    data['target_id'] = this.targetId;
    data['created_by'] = this.createdBy;
    data['is_read'] = this.isRead;
    data['params'] = this.params;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.bookingDetail != null) {
      data['booking_detail'] = this.bookingDetail.toJson();
    }
    if (this.customerDetail != null) {
      data['customer_detail'] = this.customerDetail.toJson();
    }
    return data;
  }
}

class BookingDetail {
  int targetId;
  String targetModel;
  String dataType;

  BookingDetail({this.targetId, this.targetModel, this.dataType});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    targetId = json['target_id'];
    targetModel = json['target_model'];
    dataType = json['data_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_id'] = this.targetId;
    data['target_model'] = this.targetModel;
    data['data_type'] = this.dataType;
    return data;
  }
}

class CustomerDetail {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String image;
  Role role;
  String fullName;

  CustomerDetail(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.image,
        this.role,
        this.fullName});

  CustomerDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    image = json['image'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    data['full_name'] = this.fullName;
    return data;
  }
}

class Role {
  String name;
  int id;
  Null image;
  Null category;
  List<Null> plans;
  String priceLabelMonthly;
  String priceLabelQuarterly;
  String priceLabelHalfYearly;
  String priceLabelYearly;
  List<Null> permission;
  Null currentPlan;
  String actionDate;

  Role(
      {this.name,
        this.id,
        this.image,
        this.category,
        this.plans,
        this.priceLabelMonthly,
        this.priceLabelQuarterly,
        this.priceLabelHalfYearly,
        this.priceLabelYearly,
        this.permission,
        this.currentPlan,
        this.actionDate});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    image = json['image'];
    category = json['category'];
    if (json['plans'] != null) {
      plans = new List<Null>();
      json['plans'].forEach((v) {
        plans.add(new Null.fromJson(v));
      });
    }
    priceLabelMonthly = json['price_label_monthly'];
    priceLabelQuarterly = json['price_label_quarterly'];
    priceLabelHalfYearly = json['price_label_half_yearly'];
    priceLabelYearly = json['price_label_yearly'];
    if (json['permission'] != null) {
      permission = new List<Null>();
      json['permission'].forEach((v) {
        permission.add(new Null.fromJson(v));
      });
    }
    currentPlan = json['current_plan'];
    actionDate = json['action_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    if (this.plans != null) {
      data['plans'] = this.plans.map((v) => v.toJson()).toList();
    }
    data['price_label_monthly'] = this.priceLabelMonthly;
    data['price_label_quarterly'] = this.priceLabelQuarterly;
    data['price_label_half_yearly'] = this.priceLabelHalfYearly;
    data['price_label_yearly'] = this.priceLabelYearly;
    if (this.permission != null) {
      data['permission'] = this.permission.map((v) => v.toJson()).toList();
    }
    data['current_plan'] = this.currentPlan;
    data['action_date'] = this.actionDate;
    return data;
  }
}
