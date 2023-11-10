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
}
