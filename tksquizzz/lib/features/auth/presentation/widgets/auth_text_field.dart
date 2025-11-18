import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? type;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.type,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final obscureNotifier = ValueNotifier<bool>(obscureText);

    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, isObscured, child) {
        return TextFormField(
          controller: controller,
          obscureText: isObscured,
          validator: validator,
          keyboardType: keyboardType ?? _getKeyboardType(),
          decoration: InputDecoration(
            labelText: label,
            floatingLabelStyle: TextStyle(color: Colors.indigo.shade800),
            prefixIcon: Icon(icon, color: Colors.grey.shade700, size: 16),
            suffixIcon: type == 'password'
                ? IconButton(
                    onPressed: () {
                      obscureNotifier.value = !obscureNotifier.value;
                    },
                    icon: Icon(
                      isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey[400],
                    ),
                  )
                : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1, color: Colors.indigo.shade800),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        );
      },
    );
  }

  TextInputType _getKeyboardType() {
    switch (type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'password':
        return TextInputType.visiblePassword;
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }
}
