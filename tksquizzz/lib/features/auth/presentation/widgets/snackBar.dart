import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    IconData? icon,
    String actionLabel = 'Fermer',
    Duration duration = const Duration(seconds: 4),
    EdgeInsetsGeometry margin = const EdgeInsets.all(20),
    double borderRadius = 20,
  }) {
    final snackBarConfig = _getSnackBarConfig(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon ?? snackBarConfig.icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: snackBarConfig.backgroundColor.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        action: SnackBarAction(
          label: actionLabel,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: duration,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static _SnackBarConfig _getSnackBarConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return _SnackBarConfig(
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      case SnackBarType.success:
        return _SnackBarConfig(
          backgroundColor: Colors.green.shade600,
          icon: Icons.check_circle,
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          backgroundColor: Colors.amber.shade700,
          icon: Icons.warning,
        );
      case SnackBarType.info:
      default:
        return _SnackBarConfig(
          backgroundColor: Colors.blue.shade600,
          icon: Icons.info,
        );
    }
  }
}

class _SnackBarConfig {
  final Color backgroundColor;
  final IconData icon;

  _SnackBarConfig({
    required this.backgroundColor,
    required this.icon,
  });
}

enum SnackBarType {
  error,
  success,
  warning,
  info,
}
