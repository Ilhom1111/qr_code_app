import 'package:flutter/material.dart';
import 'package:qr_code_app/constants/colors.dart';

class DropDn extends StatelessWidget {
  final String text;
  final String value;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  const DropDn(
      {super.key,
      required this.text,
      required this.value,
      this.onChanged,
      this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: CustomColors.color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        DropdownButton(
          padding: EdgeInsets.zero,
          value: value,
          dropdownColor: Colors.amber.shade50,
          alignment: Alignment.topRight,
          menuMaxHeight: 180,
          borderRadius: BorderRadius.circular(16),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: CustomColors.color,
            size: 30,
          ),
          style: TextStyle(
            color: CustomColors.color,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          underline: Container(),
          onChanged: onChanged,
          items: items,
        ),
      ],
    );
  }
}
