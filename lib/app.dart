import 'package:flutter/material.dart';
import 'pages/home_page.dart';

/// App 入口 — MaterialApp 配置
class WidgetsGuideApp extends StatelessWidget {
  const WidgetsGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets 指南',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
