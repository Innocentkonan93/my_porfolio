import 'package:flutter/material.dart';

class RippleDot extends StatefulWidget {
  final Color color;
  final double size;

  const RippleDot({
    super.key,
    this.color = const Color(0xFF439948), // Green from ProfileHeader
    this.size = 10.0,
  });

  @override
  State<RippleDot> createState() => _RippleDotState();
}

class _RippleDotState extends State<RippleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 2.5, // Allow space for ripple
      height: widget.size * 2.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ripple
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: widget.size + (widget.size * 1.5 * _controller.value),
                height: widget.size + (widget.size * 1.5 * _controller.value),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(
                    alpha: (1.0 - _controller.value).clamp(0.0, 1.0),
                  ),
                ),
              );
            },
          ),
          // Dot
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
