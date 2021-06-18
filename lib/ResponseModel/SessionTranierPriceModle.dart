class SessionAndTrainerPrince {
  bool status;
  int code;
  Data data;
  String error;

  SessionAndTrainerPrince({this.status, this.code, this.data,this.error});

  SessionAndTrainerPrince.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'] != null ? json['data'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    } if (this.error != null) {
      data['error'] = this.error;
    }
    return data;
  }
}

class Data {
  String s1;
  String s6;
  String s12;
  String s24;

  Data({this.s1, this.s6, this.s12, this.s24});

  Data.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s6 = json['6'];
    s12 = json['12'];
    s24 = json['24'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['6'] = this.s6;
    data['12'] = this.s12;
    data['24'] = this.s24;
    return data;
  }
}

