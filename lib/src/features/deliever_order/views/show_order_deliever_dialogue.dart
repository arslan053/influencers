import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/order/model/order_model.dart';

import '../controller/delievery_order_controller.dart';
import '../model/deliever_order_model.dart';

showOrderDelieverDialogue(BuildContext context,
    {required OrderModel order}) async {
  int selectedRating = 0; // default rating
  TextEditingController reviewController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String? selectedFile;
  final delieverController = Get.put(DelieveryOrderController());

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
                DelieverOrder delieverOrder = DelieverOrder(
                  orderId: order.id!,
                  receiverId: order.brandId,
                  senderId: order.influencerId,
                  status: 'delievered',
                  rating: selectedRating.toDouble(),
                  review: reviewController.text,
                  createdAt: DateTime.now(),
                  accountNumber: accountNumberController.text,
                  fileAttachment: null,
                );
                delieverController.createDeliveryOrder(
                    delieverOrder, selectedFile);
                // Process the data
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    },
  );
}
