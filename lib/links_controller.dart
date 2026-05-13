import 'package:url_launcher/url_launcher.dart';

class LinksController {
  static const String facebookUrl = 'https://www.facebook.com/profile.php?id=61576074402808';
  static const String youtubeUrl = 'https://youtube.com/shorts/Qw5zEMYAhT0?si=nBaHKEf3YmPgNq7m';
  static const String whatsappUrl = 'https://wa.me/message/XRMMREE3RC2UD1'; 

  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }
}