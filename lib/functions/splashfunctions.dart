import 'package:flutter/material.dart';
import '../screens/bottomnavigationscreen.dart';

Future<void> start(BuildContext context) async {
  await Future.delayed(
    const Duration(seconds: 3),
  );
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => BottomNaviScreen(),
    ),
  );
}
