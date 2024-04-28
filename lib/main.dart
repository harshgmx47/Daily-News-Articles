import 'package:daily_news_articles/News-Module/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Consider using a custom ThemeData to tailor the app's appearance
      theme: ThemeData(
        // Customize text styles, colors, etc. as needed (optional)
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'News Article App',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      home: NewsScreen(), // Replace `MyWidget` with the actual screen name
    );
  }
}
