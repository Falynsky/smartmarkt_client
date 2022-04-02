class BasketProduct {
  final int id;
  final int productId;
  final String name;
  final int quantity;
  final double price;
  final double summary;
  final double discountPrice;
  final int documentId;
  final String documentName;
  final String documentType;

  BasketProduct({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.summary,
    required this.discountPrice,
    required this.documentId,
    required this.documentName,
    required this.documentType,
  });

  BasketProduct.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'],
        name = json['name'],
        quantity = json['quantity'],
        price = json['price'],
        summary = json['summary'],
        discountPrice = json['discountPrice'] ?? 0,
        documentId = json['documentId'],
        documentName = json['documentName'],
        documentType = json['documentType'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'name': name,
        'quantity': quantity,
        'price': price,
        'summary': summary,
        'discountPrice': discountPrice,
        'documentId': documentId,
        'documentName': documentName,
        'documentType': documentType,
      };
}
