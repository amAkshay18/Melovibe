import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/aboutusscreen.dart';
import 'package:offlinemusicplayer/screens/privacypolicyscreen.dart';
import 'package:offlinemusicplayer/screens/termsandconditionsscreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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
              )),
        ),
        body: Column(
          children: [
            // ListTile(
            //   title: const Text('Dark Mode'),
            //   trailing: Switch(
            //     activeColor: Colors.black,
            //     value: istrue,
            //     onChanged: (value) {
            //       setState(() {
            //         istrue = value;
            //       });
            //     },
            //   ),
            // ),
            // ListTile(
            //   title: const Text('Notifications'),
            //   trailing: Switch(
            //     activeColor: Colors.grey,
            //     value: true,
            //     onChanged: (value) {},
            //   ),
            // ),
            // ListTile(
            //   title: const Text('Profile'),
            //   trailing: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ProfileScreen(),
            //         ),
            //       );
            //     },
            //     icon: const Icon(Icons.account_circle),
            //   ),
            // ),
            ListTile(
              title: const Text('Share The App'),
              trailing: IconButton(
                onPressed: () {},
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
      ),
    );
  }
}
