import 'package:flutter/material.dart';

class BrandOrderCard extends StatelessWidget {
  String? imageUrl;
  final String title;
  final String subtitle;
  final String deliveryTime;
  final String orderAmount;
  final String? buttonName1;
  final VoidCallback? onButtonPressed1;
  final String? buttonName2;
  final VoidCallback? onButtonPressed2;
  String status;

  BrandOrderCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.deliveryTime,
    required this.orderAmount,
    required this.status,
    this.buttonName1,
    this.onButtonPressed1,
    this.buttonName2,
    this.onButtonPressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: imageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl!),
                    )
                  : CircleAvatar(
                      child: Text(
                        title.substring(0, 1),
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(calculateRemainingTime(deliveryTime)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text("$orderAmount rupees"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(status),
                if (buttonName1 != null && onButtonPressed1 != null)
                  TextButton(
                    child: Text(buttonName1!),
                    onPressed: onButtonPressed1,
                  ),
                if (buttonName2 != null && onButtonPressed2 != null)
                  TextButton(
                    child: Text(buttonName2!),
                    onPressed: onButtonPressed2,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String calculateRemainingTime(String deliveryTime) {
    DateTime now = DateTime.now();
    DateTime deliveryDate = DateTime.parse(deliveryTime);
    Duration difference = deliveryDate.difference(now);
    int remainingDays = difference.inDays;
    int remainingHours = difference.inHours.remainder(24);
    return '$remainingDays days and $remainingHours hours remaining';
  }
}
