import 'dart:convert';

import 'product_model.dart';


List<OrderModel?>? orderModelFromJson(String str) => json.decode(str) == null ? [] : List<OrderModel?>.from(json.decode(str)!.map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.orderSubTotal,
    required this.orderTotal,
    required this.orderTax,
    required this.orderDiscount,
    required this.orderDeliveryFee,
    required this.orderPaymentMethodName,
    required this.orderStatus,
    required this.orderPlaceDate,
    required this.orderDeliveryAddress,
    required this.orderProducts,
  });

  int orderId;
  int orderSubTotal;
  int orderTotal;
  int orderTax;
  int orderDiscount;
  int orderDeliveryFee;
  String orderPaymentMethodName;
  String orderStatus;
  DateTime? orderPlaceDate;
  OrderDeliveryAddress orderDeliveryAddress;
  List<ProductModel> orderProducts;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"] ?? 0,
    orderSubTotal: json["orderSubTotal"] ?? 0,
    orderTotal: json["orderTotal"] ?? 0,
    orderTax: json["orderTax"] ?? 0,
    orderDiscount: json["orderDiscount"] ?? 0,
    orderDeliveryFee: json["orderDeliveryFee"] ?? 0,
    orderPaymentMethodName: json["orderPaymentMethodName"] ?? "",
    orderStatus: json["orderStatus"] ?? "",
    orderPlaceDate: json["orderPlaceDate"] != null ? DateTime.parse(json["orderPlaceDate"]) : null,
    orderDeliveryAddress: OrderDeliveryAddress.fromJson(json["orderDeliveryAddress"]),
    orderProducts: json["orderProducts"] == null ? [] : List<ProductModel>.from(json["orderProducts"]!.map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderSubTotal": orderSubTotal,
    "orderTotal": orderTotal,
    "orderTax": orderTax,
    "orderDiscount": orderDiscount,
    "orderDeliveryFee": orderDeliveryFee,
    "orderPaymentMethodName": orderPaymentMethodName,
    "orderStatus": orderStatus,
    "orderPlaceDate": orderPlaceDate?.toIso8601String(),
    "orderDeliveryAddress": orderDeliveryAddress.toJson(),
    "orderProducts": List<dynamic>.from(orderProducts.map((x) => x.toJson())),
  };
}

class OrderDeliveryAddress {
  OrderDeliveryAddress({
    this.addressId,
    this.addressFirstName,
    this.addressLastName,
    this.addressPhoneNumber,
    this.addressEmail,
    this.addressDetails,
  });

  int? addressId;
  String? addressFirstName;
  String? addressLastName;
  String? addressPhoneNumber;
  String? addressEmail;
  String? addressDetails;

  factory OrderDeliveryAddress.fromJson(Map<String, dynamic> json) => OrderDeliveryAddress(
    addressId: json["addressId"],
    addressFirstName: json["addressFirstName"],
    addressLastName: json["addressLastName"],
    addressPhoneNumber: json["addressPhoneNumber"],
    addressEmail: json["addressEmail"],
    addressDetails: json["addressDetails"],
  );

  Map<String, dynamic> toJson() => {
    "addressId": addressId,
    "addressFirstName": addressFirstName,
    "addressLastName": addressLastName,
    "addressPhoneNumber": addressPhoneNumber,
    "addressEmail": addressEmail,
    "addressDetails": addressDetails,
  };
}