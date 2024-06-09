import 'dart:convert';

class CategoryModel {
  String? image;
  String title;
  String categoryId;
  int quantity;

  CategoryModel({
    required this.image,
    required this.title,
    required this.categoryId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'image': image});
    result.addAll({'title': title});
    result.addAll({'quantity': quantity});
    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String? id) {
    return CategoryModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      categoryId: id ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source), null);
}
