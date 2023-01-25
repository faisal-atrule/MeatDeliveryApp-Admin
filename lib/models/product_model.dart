class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.details,
    required this.price,
    required this.item,
    required this.rating,
    required this.quantity,
    required this.categoryId,
    required this.attributes
  });

  int id;
  String name;
  List<String> imageUrl;
  String details;
  int price;
  int item;
  double rating;
  int quantity;
  int categoryId;
  Attributes? attributes;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    imageUrl: json["imageUrl"] != null ? List<String>.from(json["imageUrl"].map((x) => x)) : [],
    details: json["details"] ?? "",
    price: json["price"] ?? 0,
    item: json["item"] ?? 0,
    rating: json["rating"] != null ? json["rating"].toDouble() : 0.0,
    quantity: json["quantity"] ?? 0,
    categoryId: json["categoryId"] ?? 0,
    attributes: json["attributes"] != null ? Attributes.fromJson(json["attributes"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    "details": details,
    "price": price,
    "item": item,
    "rating": rating,
    "quantity": quantity,
    "categoryId": categoryId,
    "attributes": attributes?.toJson() ?? "",
  };
}

class Attributes {
  Attributes({
    required this.attributeName,
    required this.attributeValues,
  });

  String attributeName;
  List<AttributeValue> attributeValues;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    attributeName: json["attributeName"] ?? "",
    attributeValues: json["attributeValues"] != null ? List<AttributeValue>.from(json["attributeValues"].map((x) => AttributeValue.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "attributeName": attributeName,
    "attributeValues": List<dynamic>.from(attributeValues.map((x) => x.toJson())),
  };
}

class AttributeValue {
  AttributeValue({
    required this.attributeValueName,
    required this.attributeValueSelected,
  });

  String attributeValueName;
  bool attributeValueSelected;

  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
    attributeValueName: json["attributeValueName"] ?? "",
    attributeValueSelected: json["attributeValueSelected"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "attributeValueName": attributeValueName,
    "attributeValueSelected": attributeValueSelected,
  };
}