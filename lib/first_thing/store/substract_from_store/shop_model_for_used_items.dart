class UsedShopModel {
  final int id;
  final String storeKeeperName;
  final String itemNames;

  final String itemDate;
  final String takeQuantity;

  UsedShopModel({
    this.id,
    this.storeKeeperName,
    this.itemNames,
    this.itemDate,
    this.takeQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemNames': itemNames,
      'storeKeeperName': storeKeeperName,
      // 'itemPrice': itemPrice,
      'itemDate': itemDate,
      'takeQuantity': takeQuantity,
    };
  }

  static UsedShopModel fromMap(Map<String, dynamic> map) {
    return UsedShopModel(
      id: map['id'],
      itemNames: map['itemNames'],
      storeKeeperName: map['storeKeeperName'],
      takeQuantity: map['takeQuantity'],
      itemDate: map['itemDate'],
    );
  }
}
