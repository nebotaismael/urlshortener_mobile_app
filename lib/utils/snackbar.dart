import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 10,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    duration: const Duration(seconds: 3),
  );
}