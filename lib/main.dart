import 'package:appl_f/screen/splash_screen.dart';
import 'package:appl_f/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
const baseUrl =  "\"http://172.17.1.1/1096/\"";
const API_URL =   "\"http://172.17.1.1/1096/api/\"";
const WEB_BASE_URL =  "\"http://172.17.1.1/1096/ajax/route.php?\"";


// const baseUrl =  "\"https://erp.amarpadma.com/\"";
// const API_URL =   "\"https://erp.amarpadma.com/api/\"";
// const WEB_BASE_URL =  "\"https://erp.amarpadma.com/ajax/route.php?\"";


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

