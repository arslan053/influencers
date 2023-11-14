import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String category;
  String? imageUrl;

  CategoryModel({
    this.id,
    required this.category,
    this.imageUrl,
  });

  toMap() {
    return {
      "Category": category,
      "ImageUrl": imageUrl,
    };
  }

  // Map user fetched from firebase to User model
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document
        .data()!; //.get provide typical data i.e email and data provides document
    return CategoryModel(
        id: document.id,
        imageUrl: data["ImageUrl"],
        category: data["Category"]);
  }
}
