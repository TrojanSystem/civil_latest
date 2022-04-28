class ShopModelForStore {
  final int id;
  final String storeKeeperName;
  final String itemName;

  final String itemDate;
  final String itemQuantity;

  ShopModelForStore({
    this.id,
    this.storeKeeperName,
    this.itemName,
    this.itemDate,
    this.itemQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'storeKeeperName': storeKeeperName,
      'itemDate': itemDate,
      'itemQuantity': itemQuantity,
    };
  }

  static ShopModelForStore fromMap(Map<String, dynamic> map) {
    return ShopModelForStore(
      id: map['id'],
      itemName: map['itemName'],
      storeKeeperName: map['storeKeeperName'],
      itemQuantity: map['itemQuantity'],
      itemDate: map['itemDate'],
    );
  }
}
