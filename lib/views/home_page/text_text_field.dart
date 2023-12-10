import 'package:flutter/material.dart';
import 'package:qr_code_app/constants/colors.dart';

class TextTextField extends StatelessWidget {
  final TextEditingController controller;
  const TextTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: TextField(
          controller: controller,
          maxLength: 900,
          decoration: InputDecoration(
            border: InputBorder.none,
            counter: const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            fillColor: Colors.amber.shade100,
            hintText: "Enter the text",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: CustomColors.color),
            ),
          ),
        ),
      ),
    );
  }
}
