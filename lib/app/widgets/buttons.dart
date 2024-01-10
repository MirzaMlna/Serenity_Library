import 'package:flutter/material.dart';
import 'package:serenity/app/utlis/color_pallete.dart';

//
class RectangleButton extends StatefulWidget {
  const RectangleButton({
    Key? key,
    required this.color,
    required this.shadowColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Color? color;
  final Color? shadowColor;
  final String? text;
  final VoidCallback onTap;

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widget.color ?? serenityPrimary,
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            surfaceTintColor: Colors.white,
            shadowColor: widget.shadowColor ?? serenityPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            backgroundColor: widget.color ?? serenityPrimary,
          ),
          child: Text(
            widget.text ?? 'Masuk',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class CircleButton extends StatefulWidget {
  const CircleButton({
    Key? key,
    required this.color,
    required this.shadowColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Color? color;
  final Color? shadowColor;
  final String? text;
  final VoidCallback onTap;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        boxShadow: [
          BoxShadow(
            color: widget.color ?? serenityPrimary,
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            surfaceTintColor: Colors.white,
            shadowColor: widget.shadowColor ?? serenityPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(120),
            ),
            backgroundColor: widget.color ?? serenityPrimary,
          ),
          child: Text(
            widget.text ?? 'Masuk',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
    );
  }
}
