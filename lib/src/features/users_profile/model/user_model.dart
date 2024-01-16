import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ProfileModel {
  final String? id;
  String? userId;
  String? role;
  final String name;
  final String username;
  final String email;
  final String phonenumber;
  final String website;
  final String description;
  final String bio;
  String? imageUrl;
  final double rating;
  String fcm_token;
  ProfileModel(
      {this.id,
      this.userId,
      required this.name,
      required this.username,
      required this.email,
      required this.phonenumber,
      required this.website,
      required this.bio,
      required this.description,
      this.rating = 0,
      this.imageUrl,
      this.role,
      required this.fcm_token});

  toMap() {
    return {
      "UserId": userId,
      "Name": name,
      "UserName": username,
      "Email": email,
      "PhoneNumber": phonenumber,
      "Website": website,
      "Description": description,
      "Bio": bio,
      "Rating": rating,
      "ImageUrl": imageUrl,
      "Role": role,
      'fcm_token': fcm_token
    };
  }

  // Map user fetched from firebase to User model
  factory ProfileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document
        .data()!; //.get provide typical data i.e email and data provides document
    return ProfileModel(
        id: document.id,
        userId: data["UserId"] ?? "",
        name: data["Name"] ?? "",
        username: data["UserName"] ?? "",
        email: data["Email"] ?? "",
        phonenumber: data["PhoneNumber"] ?? "",
        website: data["Website"] ?? "",
        bio: data["Bio"] ?? "",
        description: data["Description"] ?? "",
        rating: data["Rating"] ?? "",
        imageUrl: data["ImageUrl"] ?? "",
        role: data["Role"] ?? "",
        fcm_token: data["fcm_token"] ?? "");
  }
}
