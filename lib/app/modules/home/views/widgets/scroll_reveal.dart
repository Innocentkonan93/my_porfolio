import 'package:flutter/material.dart';

/// Reveals content once it enters the viewport, without changing its layout.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );
  late final _curve = CurvedAnimation(
    parent: _animation,
    curve: Curves.easeOutCubic,
  );
  ScrollPosition? _scroll;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scroll = Scrollable.maybeOf(context)?.position;
    if (_scroll != scroll) {
      _scroll?.removeListener(_checkVisibility);
      _scroll = scroll?..addListener(_checkVisibility);
    }
    if (MediaQuery.disableAnimationsOf(context)) {
      _started = true;
      _animation.value = 1;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  void _checkVisibility() {
    if (!mounted || _started) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < MediaQuery.sizeOf(context).height - 32 &&
        top + box.size.height > 0) {
      _started = true;
      Future<void>.delayed(widget.delay, () {
        if (mounted && !_animation.isCompleted) _animation.forward();
      });
    }
  }

  @override
  void dispose() {
    _scroll?.removeListener(_checkVisibility);
    _curve.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _curve,
    child: SlideTransition(
      position: Tween(
        begin: const Offset(0, 0.045),
        end: Offset.zero,
      ).animate(_curve),
      child: widget.child,
    ),
  );
}
