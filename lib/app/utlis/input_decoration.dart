import 'package:flutter/material.dart';
import 'package:serenity/app/utlis/color_pallete.dart';

InputDecoration customInputDecoration(String label, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: serenitySecondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: serenityPrimary),
    ),
    labelText: label,
    contentPadding: const EdgeInsets.all(15),
    floatingLabelStyle: const TextStyle(color: serenitySecondary, fontSize: 20),
  );
}
