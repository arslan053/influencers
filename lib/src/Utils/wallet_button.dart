import 'package:flutter/material.dart';

class WalletButton extends StatelessWidget {
  final String image;
  final String text;
  const WalletButton({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159,
      height: 79,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 159,
              height: 79,
              decoration: ShapeDecoration(
                color: Color(0xFF97CD9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 14,
            bottom: 0,
            child: SizedBox(
              width: 112,
              height: 29,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 9,
            top: 14,
            bottom: 0,
            left: 100,
            child: SizedBox(
              width: 112,
              height: 29,
              child: Image.asset(image),
            ),
          ),
        ],
      ),
    );
  }
}
