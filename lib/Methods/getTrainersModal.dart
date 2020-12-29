class getTrainer {
  bool status;
  int code;
  Data data;

  getTrainer({this.status, this.code, this.data});

  getTrainer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int currentPage;
  List<DataX> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  var nextPageUrl;
  String path;
  String perPage;
  var prevPageUrl;
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

  Data.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<DataX>();
      json['data'].forEach((v) {
        data.add(new DataX.fromJson(v));
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
    if (this.data != null) {data['data'] = this.data.map((v) => v.toJson()).toList();}
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

class DataX {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String image;
  String expirence;
  String certifications;
  String specialities;
  String fullName;
  int bookingCnt;
  int bookingReviewedCnt;
  String ratingAvg;
  bool isBookedByMe;
  int isBookedByMeBookingId;
  DateDuration dateDuration;

  DataX(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.image,
        this.expirence,
        this.certifications,
        this.specialities,
        this.fullName,
        this.bookingCnt,
        this.bookingReviewedCnt,
        this.ratingAvg,
        this.isBookedByMe,
        this.isBookedByMeBookingId,
        this.dateDuration});

  DataX.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    image = json['image'];
    expirence = json['expirence'];
    certifications = json['certifications'];
    specialities = json['specialities'];
    fullName = json['full_name'];
    bookingCnt = json['booking_cnt'];
    bookingReviewedCnt = json['booking_reviewed_cnt'];
    ratingAvg = json['rating_avg'];
    isBookedByMe = json['is_booked_by_me'];
    isBookedByMeBookingId = json['is_booked_by_me_booking_id'];
    dateDuration = json['date_duration'] != null
        ? new DateDuration.fromJson(json['date_duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['expirence'] = this.expirence;
    data['certifications'] = this.certifications;
    data['specialities'] = this.specialities;
    data['full_name'] = this.fullName;
    data['booking_cnt'] = this.bookingCnt;
    data['booking_reviewed_cnt'] = this.bookingReviewedCnt;
    data['rating_avg'] = this.ratingAvg;
    data['is_booked_by_me'] = this.isBookedByMe;
    data['is_booked_by_me_booking_id'] = this.isBookedByMeBookingId;
    if (this.dateDuration != null) {
      data['date_duration'] = this.dateDuration.toJson();
    }
    return data;
  }
}

class DateDuration {
  int id;
  String startDate;
  String endDate;
  int trainerId;
  String duration;
  bool isBookedByMe;
  int availableCapacity;
  int isBookedByMeBookingId;

  DateDuration(
      {this.id,
        this.startDate,
        this.endDate,
        this.trainerId,
        this.duration,
        this.isBookedByMe,
        this.availableCapacity,
        this.isBookedByMeBookingId});

  DateDuration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    trainerId = json['trainer_id'];
    duration = json['duration'];
    isBookedByMe = json['is_booked_by_me'];
    availableCapacity = json['available_capacity'];
    isBookedByMeBookingId = json['is_booked_by_me_booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['trainer_id'] = this.trainerId;
    data['duration'] = this.duration;
    data['is_booked_by_me'] = this.isBookedByMe;
    data['available_capacity'] = this.availableCapacity;
    data['is_booked_by_me_booking_id'] = this.isBookedByMeBookingId;
    return data;
  }
}
