import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/settings/about_us.dart';
import 'package:offlinemusicplayer/screens/settings/privacy_policy.dart';
import 'package:offlinemusicplayer/screens/settings/terms_and_conditions.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('Share The App'),
              trailing: IconButton(
                onPressed: () {
                  _shareApp();
                },
                icon: const Icon(Icons.share),
              ),
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: IconButton(
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.privacy_tip),
              ),
            ),
            ListTile(
              title: const Text('Terms & Conditions'),
              trailing: IconButton(
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              title: const Text('About Us'),
              trailing: IconButton(
                onPressed: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }

// Method to show the share dialog with a predefined text
  void _shareApp() {
    const String text = 'live_link_of_the_application';
    Share.share(text);
  }
}
