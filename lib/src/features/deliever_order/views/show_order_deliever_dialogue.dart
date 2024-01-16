import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

showOrderDelieverDialogue(BuildContext context) async {
  int selectedRating = 0; // default rating
  TextEditingController reviewController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String? selectedFile;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      int selectedRating = 0; // default rating
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text('Rate and Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Rating Selector
              Wrap(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < selectedRating ? Icons.star : Icons.star_border,
                    ),
                    color: Colors.amber,
                    onPressed: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              // Review TextField
              TextField(
                controller: reviewController,
                decoration: InputDecoration(hintText: 'Enter your review'),
              ),
              // Account Number TextField
              TextField(
                controller: accountNumberController,
                decoration:
                    InputDecoration(hintText: 'Enter your account number'),
              ),
              // File Picker
              ElevatedButton(
                child: Text('Attach File'),
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    selectedFile = result.files.single.path;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // Process the data
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    },
  );

  // Use the data from the modal
  // print('Rating: $selectedRating');
  print('Review: ${reviewController.text}');
  print('Account Number: ${accountNumberController.text}');
  print('Selected File: $selectedFile');
}
