import 'package:appl_f/common/default_app_bar.dart';
import 'package:flutter/material.dart';

class UploadPanScreen extends StatefulWidget {
  const UploadPanScreen({super.key});

  @override
  State<UploadPanScreen> createState() => _UploadPanScreenState();
}

class _UploadPanScreenState extends State<UploadPanScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: DefaultAppBar(title: 'Upload Pan', size: size),

    );
  }
}
