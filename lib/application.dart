import 'dart:ui';

import 'package:artiqr/page/about_page.dart';
import 'package:artiqr/page/history_page.dart';
import 'package:artiqr/page/home_page.dart';
import 'package:artiqr/theme/artiqr_theme.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ArtiqrTheme.dark(),
      scrollBehavior: MyCustomScrollBehavior(),
      routes: {
        '/': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/about': (context) => AboutPage(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
