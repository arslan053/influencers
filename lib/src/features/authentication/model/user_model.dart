import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String username;
  final String email;
  final String phonenumber;
  final String website;
  final String description;
  final String bio;
  String? imageUrl;
  final double rating;

  UserModel(
      {this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phonenumber,
      required this.website,
      required this.bio,
      required this.description,
      this.rating = 0,
      this.imageUrl});

  toMap() {
    return {
      "Name": name,
      "UserName": username,
      "Email": email,
      "PhoneNumber": phonenumber,
      "Website": website,
      "Description": description,
      "Bio": bio,
      "Rating": rating,
      "ImageUrl": imageUrl
    };
  }

  // Map user fetched from firebase to User model
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document
        .data()!; //.get provide typical data i.e email and data provides document
    return UserModel(
        id: document.id,
        name: data["Name"],
        username: data["UserName"],
        email: data["Email"],
        phonenumber: data["PhoneNumber"],
        website: data["Website"],
        bio: data["Bio"],
        description: data["Description"],
        rating: data["Rting"],
        imageUrl: data["ImageUrl"]);
  }
}
