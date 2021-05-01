
class ProductHistory {
  final int quantity;
  final String productName;
  final double purchasedPrice;

  ProductHistory({
    required this.quantity,
    required this.productName,
    required this.purchasedPrice,
  });

  ProductHistory.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        productName = json['productName'],
        purchasedPrice = json['purchasedPrice'];

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'productName': productName,
        'purchasedPrice': purchasedPrice,
      };
}
