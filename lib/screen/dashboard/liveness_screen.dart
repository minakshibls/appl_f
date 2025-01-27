import 'package:appl_f/common/default_app_bar.dart';
import 'package:appl_f/utils/colors.dart';
import 'package:flutter/material.dart';

class LivenessScreen extends StatefulWidget {
  const LivenessScreen({super.key});

  @override
  State<LivenessScreen> createState() => LivenessScreenState();
}

class LivenessScreenState extends State<LivenessScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: DefaultAppBar(title: 'Liveness', size: size),

    );
  }
}
