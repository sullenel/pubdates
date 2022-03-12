import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  const UrlOpener();

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
