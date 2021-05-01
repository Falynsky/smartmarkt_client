class Product {
  int id;
  String name;
  int quantity;
  double price;
  double weight;
  int productTypeId;
  String productInfo;
  int documentId;
  String documentName;
  String documentType;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.weight,
    required this.productTypeId,
    required this.productInfo,
    required this.documentId,
    required this.documentName,
    required this.documentType,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        quantity = json['quantity'],
        price = json['price'],
        weight = json['weight'],
        productTypeId = json['productTypeId'],
        productInfo = json['productInfo'],
        documentId = json['documentId'],
        documentName = json['documentName'],
        documentType = json['documentType'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'weight': weight,
        'productTypeId': productTypeId,
        'productInfo': productInfo,
        'documentId': documentId,
        'documentName': documentName,
        'documentType': documentType,
      };
}
