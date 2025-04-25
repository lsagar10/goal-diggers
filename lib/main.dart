import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:goal_diggers/src/feature/home/presentation/homepage.dart';

import 'package:goal_diggers/src/feature/home/presentation/sections/ball_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/boot_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/jersey_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/retro_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/socks_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/track_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> appRoutes = {
      '/jersey': (context) => JerseyPage(),
      '/boots': (context) => BootPage(),
      '/football': (context) => BallPage(),
      '/track': (context) => TrackPage(),
      '/retro': (context) => RetroPage(),
      '/socks': (context) => SocksPage(),
    };

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: appRoutes,
    );
  }
}
