class Data {
  String token;
  List<dynamic> gym_members;

  List<dynamic> pool_and_beach_members;
  List<dynamic> local_guest;
  List<dynamic> fairmont_hotel_guest;

//  e user;

  Data(
      {this.token,
      this.gym_members,
      this.pool_and_beach_members,
      this.local_guest,
      this.fairmont_hotel_guest});

  Data.fromJson(Map<String, dynamic> json) {
    gym_members = json['gym_members'] != null
        ? json['gym_members']
        : null;
    pool_and_beach_members = json['pool_and_beach_members'] != null
        ? json['pool_and_beach_members']
        : null;
    local_guest = json['local_guest'] != null ? json['local_guest'] : null;
    fairmont_hotel_guest = json['fairmont_hotel_guest'] != null
        ? json['fairmont_hotel_guest']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['token'] = this.token;
    if (this.gym_members != null) {
      data['gym_members'] = this.gym_members;


    }

    if (this.pool_and_beach_members != null) {
      data['pool_and_beach_members'] = this.pool_and_beach_members;
    }

    if (this.local_guest != null) {
      data['local_guest'] = this.local_guest;
    }

    if (this.gym_members != null) {
      data['fairmont_hotel_guest'] = this.fairmont_hotel_guest;
      print("fkshhfks gfgfg"+this.fairmont_hotel_guest.toString());
    }
  }
}
