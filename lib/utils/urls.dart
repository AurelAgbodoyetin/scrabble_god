import 'package:url_launcher/url_launcher.dart';

Future<void> contactUs() async {
  if (!await launchUrl((Uri.parse("mailto:taudev2020@gmail.com")))) {
    throw 'Could not launch';
  }
}
