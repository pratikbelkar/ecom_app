import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'products.g.dart';

@JsonSerializable()
@HiveType(typeId: 01)
class Products {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? category;
  @HiveField(4)
  num? price;
  @HiveField(5)
  num? discountPercentage;
  @HiveField(6)
  num? rating;
  @HiveField(7)
  int? stock;
  @HiveField(8)
  List? tags;
  @HiveField(9)
  String? brand;
  @HiveField(10)
  String? sku;
  @HiveField(11)
  num? weight;
  @HiveField(12)
  Map<String, dynamic>? dimensions;
  @HiveField(13)
  String? warrantyInformation;
  @HiveField(14)
  String? shippingInformation;
  @HiveField(15)
  String? availabilityStatus;
  @HiveField(16)
  List? reviews;
  @HiveField(17)
  String? returnPolicy;
  @HiveField(18)
  int? minimumOrderQuantity;
  @HiveField(19)
  List<dynamic>? images;
  @HiveField(20)
  String? thumbnail;

  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
  });

  // from json function
  // Converts the JSON object to a Products Object

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
