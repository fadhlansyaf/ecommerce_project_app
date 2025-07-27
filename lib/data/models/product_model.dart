import '../../domain/entity/product_entity.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel extends ProductEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String description;

  @HiveField(3)
  @override
  final double price;

  @HiveField(4)
  @override
  final String imageUrl;

  @HiveField(5)
  @override
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          createdAt: createdAt,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}