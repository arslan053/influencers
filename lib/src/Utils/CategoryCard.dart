import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String  path;
  final String  text;
  const CategoryCard({Key? key, required this.path, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Container(
          height: 77,
          width: 79,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(path,fit: BoxFit.cover,)
          ),
        Text(text),
              ]),
    );
  }
}