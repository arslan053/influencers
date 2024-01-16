import 'package:flutter/material.dart';

class Inboxcard extends StatelessWidget {
  final String image;
  final String name;
  final subtitle_text;
  const Inboxcard(
      {Key? key, required this.image, required this.name, this.subtitle_text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("The value of image is $image");
    return ListTile(
      leading: (image != null && image.isNotEmpty)
          ? CircleAvatar(
              backgroundImage: NetworkImage(image),
            )
          : CircleAvatar(
              child: Text(
                name.substring(0, 1),
              ),
            ),
      title: Text(name),
      subtitle: Text(subtitle_text),
    );
  }
}
