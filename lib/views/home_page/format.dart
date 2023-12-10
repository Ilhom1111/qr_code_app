import 'package:flutter/material.dart';

sealed class Format {
  static const List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(
      value: "png",
      child: Text("PNG"),
    ),
    DropdownMenuItem(
      value: "jpg",
      child: Text("JPG"),
    ),
    DropdownMenuItem(
      value: "jpeg",
      child: Text("JPEG"),
    ),
    DropdownMenuItem(
      value: "svg",
      child: Text("SVG"),
    ),
  ];
}
