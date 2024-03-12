import 'package:flutter/material.dart';

class TextFieldHelper {
  static InputDecoration getInputDecoration(
          String hintText, IconData? icon, bool notLabeled) =>
      InputDecoration(
        hintText: hintText,
        labelText: notLabeled ? null : hintText,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 16.5, fontWeight: FontWeight.w300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
        ),
      );
}
