import 'package:flutter/material.dart';

class ChartData {
  ChartData([this.x, this.y, this.color]);

  String? x;
  dynamic y;
  Color? color;
  int? quantity;

  void setQuantity(int quantity){
    this.quantity = quantity;
  }
}


//