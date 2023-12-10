import 'package:flutter/material.dart';

class ColorContayner extends StatefulWidget {
  final Color color;
  final Function() funksiya;
  const ColorContayner(
      {super.key, required this.color, required this.funksiya});

  @override
  State<ColorContayner> createState() => _ColorContaynerState();
}

class _ColorContaynerState extends State<ColorContayner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.funksiya,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
