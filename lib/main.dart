import 'package:appl_f/screen/splash_screen.dart';
import 'package:appl_f/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
// const baseUrl =  "http://172.17.1.1/1096/api/";
// const baseUrl =  "http://uat.bridgelogicsoftware.com/1096/api/";
const baseUrl =  "https://erp.amarpadma.com/api/";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 1096',
      theme: ThemeData(
        fontFamily: GoogleFonts.workSans().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

