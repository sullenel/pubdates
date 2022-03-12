import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as html;
import 'package:pubdates/common/constants/colors.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/common/widgets/space.dart';

class HtmlContent extends StatelessWidget {
  const HtmlContent({
    Key? key,
    required this.text,
    this.onLinkPressed,
  }) : super(key: key);

  final String text;
  final ValueSetter<String>? onLinkPressed;

  Widget? _customWidgetBuilder(html.Element el) {
    // No idea how to remove hash links otherwise
    if (el.localName == 'a' && el.classes.contains('hash-link')) {
      return Nothing;
    }

    return null;
  }

  Map<String, String>? _customStylesBuilder(html.Element el) {
    switch (el.localName) {
      case 'a':
        return {
          'color': AppColors.link.toHex(),
          'text-decoration': 'none',
        };
      case 'pre':
      case 'code':
        return {
          'background-color': AppColors.code.toHex(),
        };
      case 'h3':
        return const {
          'font-weight': '400',
        };
      case 'ul':
        return const {
          'margin': '0',
          'padding': '0 ${AppInsets.md}px ${AppInsets.sm}px ${AppInsets.md}px',
        };
    }

    return null;
  }

  bool _handleLink(String url) {
    onLinkPressed?.call(url);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      text,
      enableCaching: true,
      onTapUrl: _handleLink,
      customWidgetBuilder: _customWidgetBuilder,
      customStylesBuilder: _customStylesBuilder,
    );
  }
}
