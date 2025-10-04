import 'package:flutter/material.dart';

class AnimatedHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedHoverCard({super.key, required this.child, this.onTap});

  @override
  State<AnimatedHoverCard> createState() => _AnimatedHoverCardState();
}

class _AnimatedHoverCardState extends State<AnimatedHoverCard> {
  bool _isHovered = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final double elevation = _isHovered || _isTapped ? 12.0 : 4.0;
    final double scale = _isTapped ? 0.98 : (_isHovered ? 1.02 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) {
          setState(() => _isTapped = false);
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onTapCancel: () => setState(() => _isTapped = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: Matrix4.diagonal3Values(scale, scale, 1.0),
          transformAlignment: FractionalOffset.center,
          child: Card(
            elevation: elevation,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
