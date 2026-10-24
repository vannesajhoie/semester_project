import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color, textColor;
  final bool outline;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.outline = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
    const pad = EdgeInsets.symmetric(vertical: 16);
    return SizedBox(
      width: double.infinity,
      child: outline
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  foregroundColor: color ?? kGreen,
                  side: BorderSide(color: color ?? kGreen),
                  padding: pad,
                  shape: shape),
              child: Text(label))
          : FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                  backgroundColor: color ?? kGreen,
                  foregroundColor: textColor ?? Colors.black,
                  padding: pad,
                  shape: shape),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
    );
  }
}