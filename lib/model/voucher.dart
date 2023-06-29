import 'dart:convert';

class Voucher {
  final String name;
  final String type;
  final int quantity;
  final String expirationDate;
  final String price;

  Voucher({
    required this.name,
    required this.type,
    required this.quantity,
    required this.expirationDate,
    required this.price,
  });

  factory Voucher.fromJson(String str) => Voucher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Voucher.fromMap(Map<String, dynamic> json) => Voucher(
        name: json["name"],
        type: json["type"],
        quantity: json["quantity"],
        expirationDate: json["expirationDate"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "quantity": quantity,
        "expirationDate": expirationDate,
        "price": price,
      };
}
