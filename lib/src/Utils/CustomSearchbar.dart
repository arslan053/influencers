import 'package:flutter/material.dart';
class CustomSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Container(
         // Set the width of the search field
        decoration: BoxDecoration(
          color: Colors.grey, // Background color
          borderRadius: BorderRadius.circular(8.0), // Border radius
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none, // No border
            contentPadding: EdgeInsets.all(16.0), // Padding inside the field
            suffixIcon: Icon(Icons.search, color: Colors.green.shade300,)
    
          ),
        ),
      ),
    );
  }
}