import 'package:flutter/material.dart';

class ValidatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color primaryColor;
  final Color disabledColor;
  final Color textColor;
  final Color progressColor;
  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  const ValidatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.primaryColor = const Color.fromARGB(255, 8, 32, 91),
    this.disabledColor = Colors.grey,
    this.textColor = Colors.white,
    this.progressColor = Colors.white,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 8,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: isLoading ? disabledColor : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: isLoading ? primaryColor.withOpacity(0.6) : primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isLoading ? null : onPressed,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(0),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: progressColor,
                          strokeWidth: 3,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            icon!,
                            const SizedBox(width: 8),
                          ],
                          Text(
                            text,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}