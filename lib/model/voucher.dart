import 'dart:convert';

class Voucher {
  final String name;
  final String type;
  final String quantity;
  final String expirationDate;
  final String price;
  final List<String> users;

  Voucher({
    required this.name,
    required this.type,
    required this.quantity,
    required this.expirationDate,
    required this.price,
    required this.users,
  });

  factory Voucher.fromJson(String str) => Voucher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Voucher.fromMap(Map<String, dynamic> json) => Voucher(
        name: json["name"],
        type: json["type"],
        quantity: json["quantity"],
        expirationDate: json["expirationDate"],
        price: json["price"],
        users: List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "quantity": quantity,
        "expirationDate": expirationDate,
        "price": price,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}
