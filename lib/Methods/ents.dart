import 'package:flutter/material.dart';
class Evet {
  //assets/default1.png
  String id;
  String name;
  String image;

  Evet({
    this.id,
    @required this.name,
    this.image,
  });

  Evet.fromJson(Map<String, dynamic> data)
      : id = data['data']['id'],
        name = data['data']["name"].toString(),
        image = data['data']['image'];
}

// List<Evet> blockedUsers = [
//   new Evet(
//       functionl: "dfdf",
//       // status: "UNBLOCK",
//       avatarUrl:
//           "https://ramcotubular.com/wp-content/uploads/default-avatar.jpg"),
//   new Evet(
//       functionl: "fdfaa",
//       // status: "UNBLOCK",
//       avatarUrl:
//           "https://ramcotubular.com/wp-content/uploads/default-avatar.jpg"),
// ];
