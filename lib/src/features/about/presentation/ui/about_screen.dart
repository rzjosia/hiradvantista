import "package:flutter/material.dart";
import 'package:flutter_donation_buttons/donationButtons/paypalButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hiradvantista/src/common_widgets/icon_link.dart';
import 'package:hiradvantista/src/constants/app_info.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static const paddingColumn = Padding(padding: EdgeInsets.only(bottom: 10.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mombamomba'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/icon.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                AppInfo().description,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconLink(
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      url: AppInfo().developerLinkedin),
                  IconLink(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      url: AppInfo().developerGithub),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Version : ${AppInfo().version}",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: PayPalButton(paypalButtonId: AppInfo().developerPaypal),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Copyright : ${AppInfo().copyRight}",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
