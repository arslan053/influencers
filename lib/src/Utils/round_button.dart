import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RoundButton extends StatefulWidget {
  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;

  const RoundButton(
      {key,
      this.loading = false,
      required this.title,
      this.height = 50,
      this.width = 60,
      required this.onPress,
      this.textColor = Colors.white,
      this.buttonColor = Colors.black26});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
      ),
    );
  }
}
