import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IconLink extends StatelessWidget {
  final FaIcon icon;
  final String url;

  const IconLink({required this.icon, required this.url, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    onPressed() {
      try {
        launchUrlString(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text('Error launching url: $url'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ));
      }
    }

    return IconButton(onPressed: onPressed, icon: icon);
  }
}
