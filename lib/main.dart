import 'package:flutter/material.dart';
import 'package:planet/page/detail_page.dart';
import 'package:planet/page/fav_page.dart';
import 'package:planet/page/home_page.dart';
import 'package:planet/page/splash_page.dart';
import 'package:planet/provider/planet_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: PlanetProvider())],
      child: MaterialApp(
        initialRoute: 'homepage',
        routes: {
          "/splah": (context) => const SplashPage(),
          "homepage": (context) => HomePage(),
          "details": (context) => const DetailPage(),
          "fav": (context) => const FavPage(),
        },
      ),
    );
  }
}
