import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icon;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isOutlined ? Colors.transparent : (color ?? Theme.of(context).primaryColor),
      foregroundColor: isOutlined ? (color ?? Theme.of(context).primaryColor) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOutlined
            ? BorderSide(color: color ?? Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      elevation: isOutlined ? 0 : 3,
    );

    return ElevatedButton.icon(
      style: buttonStyle,
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
