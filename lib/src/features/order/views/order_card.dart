import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  String? imageUrl;
  final String title;
  final String subtitle;
  final String deliveryTime;
  final String orderAmount;
  final VoidCallback? onButtonPressed1;
  final VoidCallback? onButtonPressed2;

  OrderCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.deliveryTime,
    required this.orderAmount,
    this.onButtonPressed1,
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
                  Text("$deliveryTime day"),
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
                TextButton(
                  child: Text("Accept"),
                  onPressed: onButtonPressed1,
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: Text("Reject"),
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
}
