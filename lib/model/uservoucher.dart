import 'dart:convert';

class UserVoucher {
  final String id;
  final String uid;
  final String vid;
  final String status;

  UserVoucher({
    required this.id,
    required this.uid,
    required this.vid,
    required this.status,
  });

  factory UserVoucher.fromJson(String str) =>
      UserVoucher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserVoucher.fromMap(Map<String, dynamic> json) => UserVoucher(
        id: json["id"],
        uid: json["uid"],
        vid: json["vid"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uid": uid,
        "vid": vid,
        "status": status,
      };
}
