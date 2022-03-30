import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pubdates/common/constants/constants.dart';

class FlipOnHover extends StatefulWidget {
  const FlipOnHover({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);

  final Widget front;
  final Widget back;

  @override
  State<FlipOnHover> createState() => _FlipOnHoverState();
}

class _FlipOnHoverState extends State<FlipOnHover> {
  var _isHovered = false;

  void _handleHover(PointerHoverEvent event) {
    if (!_isHovered) {
      setState(() => _isHovered = true);
    }
  }

  void _handleExit(PointerExitEvent event) {
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _handleHover,
      onExit: _handleExit,
      child: AnimatedSwitcher(
        duration: AppConstants.defaultAnimationDuration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: _isHovered ? widget.back : widget.front,
      ),
    );
  }
}
