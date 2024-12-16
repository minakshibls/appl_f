
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/session_helper.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    final userId = await SessionHelper.getSessionData(SessionKeys.userId);

    if(!mounted) return;

    if (userId != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      await Future.delayed(const Duration(seconds: 1), () {});

      if(!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset('assets/images/ic_logo.png',
              width: size.width * 0.7, height: size.height * 0.3)),
    );
  }
}
