import 'package:flutter/material.dart';
import 'package:pubdates/common/utils/window_utils.dart';

class WindowTitle extends StatefulWidget {
  const WindowTitle({
    Key? key,
    this.title,
    required this.child,
  }) : super(key: key);

  final String? title;
  final Widget child;

  @override
  State<WindowTitle> createState() => _WindowTitleState();
}

class _WindowTitleState extends State<WindowTitle> {
  @override
  void initState() {
    super.initState();

    if (widget.title != null) {
      _updateTitle();
    }
  }

  @override
  void didUpdateWidget(WindowTitle oldWidget) {
    if (widget.title != oldWidget.title) {
      _updateTitle();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // FIXME: figure out whether it is the right way to do it
    context.restoreWindowTitle();
    super.deactivate();
  }

  void _updateTitle() {
    context.updateWindowTitle(widget.title!);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
