import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String path;
  final String text;
  final double? height;
  final double? width;

  const CategoryCard(
      {Key? key,
      required this.path,
      required this.text,
      this.height = 79,
      this.width = 77})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Container(
            height: height,
            width: width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            )),
        SizedBox(
          height: 3,
        ),
        Text(text),
      ]),
    );
  }
}
