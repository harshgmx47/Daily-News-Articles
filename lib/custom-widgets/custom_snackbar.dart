import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar buildSnackBar({
    required String message,
    required BuildContext context,
    VoidCallback? onActionPressed,
    String actionText = "",
  }) {
    return SnackBar(
      content: Material(
        // Ensures background doesn't block content
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Wraps content
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              if (actionText.isNotEmpty)
                TextButton(
                  onPressed: onActionPressed,
                  child: Text(
                    actionText,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
            ],
          ),
        ),
      ), // Customize duration
      backgroundColor: Colors.black87, // Set background color directly
      padding: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    );
  }
}
