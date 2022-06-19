import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  const UrlOpener();

  Future<void> openUrl(String url) async {
    final parsed = Uri.tryParse(url);

    if (parsed != null && await canLaunchUrl(parsed)) {
      await launchUrl(parsed);
    }
  }
}
