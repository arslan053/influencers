// The method to show the bid dialog
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/bids/controller/bid_controller.dart';

import '../../../repository/bid_repository/bid_repository.dart';
import '../model/bid_model.dart';

Future<void> ShowBidDialogue(
    BuildContext context, String campaignId, String influencerId) async {
  final _formKey = GlobalKey<FormState>();
  double bidAmount = 0.0;
  String remarks = '';
  int deliveryDays = 0;
  final bidController = Get.put(BidController());

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button to close
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Place Your Bid'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Bid Amount'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a bid amount';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        bidAmount = double.parse(value!);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Delivery Days'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of delivery days';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        deliveryDays = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Remarks'),
                      onSaved: (value) {
                        remarks = value ?? '';
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit Bid'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Handle the bid submission logic here
                Bid newBid = Bid(
                    campaignId: campaignId,
                    influencerId: influencerId,
                    bidAmount: bidAmount,
                    remarks: remarks,
                    createdAt: DateTime.now(),
                    deliveryDays: deliveryDays);
                // For example, you can use a function to submit this 'newBid' to Firebase
                bidController.makeBid(newBid);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
