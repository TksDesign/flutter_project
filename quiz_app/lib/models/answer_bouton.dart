import 'package:flutter/material.dart';

class AnswerBouton extends StatefulWidget {
  const AnswerBouton({super.key, required this.text, required this.onTap});
  final String text;
  final void Function() onTap;
  @override
  State<AnswerBouton> createState() => _AnswerBoutonState();
}

class _AnswerBoutonState extends State<AnswerBouton> {
  bool _ispressed = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: _ispressed
                ? const Color.fromARGB(188, 245, 245, 245)
                : const Color.fromARGB(155, 152, 103, 198),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(04),
            ),
            side: const BorderSide(width: 0, color: Colors.transparent)),
        onPressed: () async {
          setState(() {
            _ispressed = !_ispressed;
          });
          await Future.delayed(const Duration(milliseconds: 300));

          widget.onTap();
        },
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.text,
              style: TextStyle(
                  color: _ispressed
                      ? Colors.grey
                      : const Color.fromARGB(255, 91, 39, 140),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}
