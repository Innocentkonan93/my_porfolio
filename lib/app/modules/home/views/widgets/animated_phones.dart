import 'package:flutter/material.dart';

class AnimatedPhones extends StatefulWidget {
  const AnimatedPhones({super.key, required this.mobile});

  final bool mobile;

  @override
  State<AnimatedPhones> createState() => _AnimatedPhonesState();
}

class _AnimatedPhonesState extends State<AnimatedPhones>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
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
    if (top < MediaQuery.sizeOf(context).height - 80 &&
        top + box.size.height > 0) {
      _started = true;
      _animation.forward();
    }
  }

  @override
  void dispose() {
    _scroll?.removeListener(_checkVisibility);
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final slot = constraints.maxWidth / 3;
      final width = slot - (widget.mobile ? 20 : 76);
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final rise = const Interval(
            0,
            0.45,
            curve: Curves.easeOutCubic,
          ).transform(_animation.value);
          final spread = const Interval(
            0.48,
            1,
            curve: Curves.easeInOutCubic,
          ).transform(_animation.value);
          return Opacity(
            opacity: rise,
            child: Transform.translate(
              offset: Offset(0, (1 - rise) * 180),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Paint the middle phone last so it stays in front of the stack.
                  for (final item in [
                    ('assets/images/cutit.png', -1),
                    ('assets/images/cvf.png', 1),
                    ('assets/images/riise.png', 0),
                  ])
                    Positioned(
                      left:
                          (constraints.maxWidth - width) / 2 +
                          item.$2 * slot * spread,
                      top: 0,
                      width: width,
                      height: constraints.maxHeight,
                      child: Transform.rotate(
                        angle: item.$2 * 0.08 * spread,
                        child: Image.asset(
                          item.$1,
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
