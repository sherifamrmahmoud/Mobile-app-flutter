import 'package:flutter/material.dart';

class SnackBarHelper {
  static void success(BuildContext context, String message) {
    _show(context, message, Colors.green, Icons.check_circle);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, Colors.red, Icons.error);
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 10,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
