import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:offlinemusicplayer/screens/splash/splash.dart';
import 'database/model/favorite_model.dart';
import 'database/model/playlist_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AllSongModelAdapter().typeId)) {
    Hive.registerAdapter(AllSongModelAdapter());
  }
  if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  await Hive.openBox<AllSongModel>('favorite');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    mediaQueryData.platformBrightness;

    if (mediaQueryData.platformBrightness == Brightness.light) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    } else {
      FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent)),
      home: const ScreenSplash(),
    );
  }
}
