import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  int id;
  int total;
  bool checked = false;
  String name;
  String quantity;
  String date;
  String price;

  Shop({
    this.total,
    this.id,
    this.date,
    this.quantity,
    this.price,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'date': date,
      'total': total
      // 'checked': checked
    };
  }

  static Shop fromMap(Map<String, dynamic> map) {
    return Shop(
        id: map['id'],
        name: map['name'],
        quantity: map['quantity'],
        price: map['price'],
        date: map['date'],
        total: map['total']
        // checked: map['checked'],
        );
  }
}
