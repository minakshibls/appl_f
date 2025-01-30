import 'dart:io';

import 'package:appl_f/common/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../common/primary_button.dart';

class UploadAadarScreen extends StatefulWidget {
  const UploadAadarScreen({super.key});

  @override
  State<UploadAadarScreen> createState() => UploadAadhaarScreenState();
}

class UploadAadhaarScreenState extends State<UploadAadarScreen> {
  File? _aadharFrontImage;
  File? _aadharBackImage;
  String? _name;
  String? _dob;
  String? _aadharNumber;
  String? _address;
  final picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _aadharFrontImage = File(pickedFile.path);
          _processImage(_aadharFrontImage!, isFront);
        } else {
          _aadharBackImage = File(pickedFile.path);
          _processImage(_aadharBackImage!, isFront);
        }
      });
    }
  }

  Future<void> _processImage(File image, bool isFront) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        String text = line.text;
        if (RegExp(r"^\\d{4}\\s\\d{4}\\s\\d{4}$").hasMatch(text)) {
          setState(() => _aadharNumber = text.replaceAll(' ', ''));
        } else if (RegExp(r'\d{2}/\d{2}/\d{4}').hasMatch(text)) {
          setState(() => _dob = text);
        } else if (text.contains("Government of India")) {
          setState(() => _name = block.lines[1].text);
        } else {
          setState(() => _address = text);
        }
      }
    }
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar(title: 'Upload Aadhaar Card', size: size),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Front Aadhaar Image',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _aadharFrontImage != null
                        ? Image.file(
                      _aadharFrontImage!,
                      fit: BoxFit.cover,
                    )
                        : const Center(
                      child: Icon(Icons.image, size: 50.0, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => _pickImage(true), // Pick front image
                  child: const Text('Choose File'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            const Text(
              'Back Aadhaar Image',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _aadharBackImage != null
                        ? Image.file(
                      _aadharBackImage!,
                      fit: BoxFit.cover,
                    )
                        : const Center(
                      child: Icon(Icons.image, size: 50.0, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => _pickImage(false), // Pick back image
                  child: const Text('Choose File'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Aadhaar Number (Non-editable)
            TextField(
              controller: TextEditingController(text: _aadharNumber),
              decoration: const InputDecoration(
                labelText: 'Aadhaar Number',
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            const SizedBox(height: 16.0),

            // Customer Name (Non-editable)
            TextField(
              controller: TextEditingController(text: _name),
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Date of Birth (Non-editable)
            TextField(
              controller: TextEditingController(text: _dob),
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            const SizedBox(height: 16.0),

            // Address (Non-editable)
            TextField(
              controller: TextEditingController(text: _address),
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            const SizedBox(height: 24.0),

            PrimaryButton(onPressed: () {}, context: context, text: 'Save'),
          ],
        ),
      ),
    );
  }
}
