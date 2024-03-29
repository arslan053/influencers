import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  String? imageUrl;
  final String title;
  final String subtitle;
  final String deliveryTime;
  final String orderAmount;
  final String onButtonPressed1;
  final VoidCallback? onButtonPressed2;

  OrderCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.deliveryTime,
    required this.orderAmount,
    required this.onButtonPressed1,
    this.onButtonPressed2,
  });

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
                Text(onButtonPressed1),
                // TextButton(
                //   child: Text("Accept"),
                //   onPressed: onButtonPressed1,
                // ),
                const SizedBox(width: 8),
                TextButton(
                  child: Text("Submit"),
                  onPressed: onButtonPressed2,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String calculateRemainingTime(String deliveryTime) {
    DateTime now = DateTime.now();

    // Extract the date part and convert it to DateTime
    DateTime deliveryDate = DateTime.parse(deliveryTime);

    // Calculate the difference
    Duration difference = deliveryDate.difference(now);

    // Extract remaining days and hours
    int remainingDays = difference.inDays;
    int remainingHours = difference.inHours.remainder(24);

    // Format the result
    return '$remainingDays days and $remainingHours hours remaining';
  }
}
