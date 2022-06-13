import 'package:flutter/material.dart';
import 'package:strider/presentation/pages/home_page.dart';
import 'package:strider/shared/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Posterr",
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}

