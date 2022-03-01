class Labours {
  int id;
  String name;
  String title;
  String price;
  String date;
  String phoneNumber;

  Labours(
      {this.id,
      this.price,
      this.name,
      this.phoneNumber,
      this.title,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'price': price,
      'date': date,
      'phoneNumber': phoneNumber,
    };
  }

  static Labours fromMap(Map<String, dynamic> map) {
    return Labours(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      price: map['price'],
      date: map['date'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
