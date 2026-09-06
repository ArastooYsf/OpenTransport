import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The app logo with a slow, gentle scale pulse — decorative motion kept to
/// the minimum design.md allows ("keep decorative motion minimal"), just
/// enough to signal "alive, working" without feeling flashy.
class PulsingLogo extends StatefulWidget {
  const PulsingLogo({super.key, this.size = 120});

  final double size;

  @override
  State<PulsingLogo> createState() => _PulsingLogoState();
}

class _PulsingLogoState extends State<PulsingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);

  late final Animation<double> _scale = Tween<double>(
    begin: 1,
    end: 1.05,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: SvgPicture.asset(
        'assets/logo_placeholder.svg',
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
