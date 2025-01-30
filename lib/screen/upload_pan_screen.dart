import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../common/primary_button.dart';

class UploadPanScreen extends StatefulWidget {
  const UploadPanScreen({super.key});

  @override
  UploadPanScreenState createState() => UploadPanScreenState();
}

class UploadPanScreenState extends State<UploadPanScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _panImage;
  String? _panNumber;
  String? _dob;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _panImage = File(pickedFile.path);
      });
      _processImage(_panImage!);
    }
  }

  Future<void> _processImage(File image) async {
    if (!image.existsSync()) {
      print("Error: Image file does not exist.");
      return;
    }

    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      String? panNumber;
      String? dob;

      List<String> lines = recognizedText.text.split('\n');

      for (String text in lines) {
        text = text.trim();

        if (RegExp(r'^[A-Za-z]{5}[0-9]{4}[A-Za-z]$').hasMatch(text)) {
          panNumber = text;
        } else if (RegExp(
                r'\b(0[1-9]|[12][0-9]|3[01])[-/](0[1-9]|1[0-2])[-/](19|20)\d\d\b')
            .hasMatch(text)) {
          dob = text;
        } else if (text.length > 3 &&
            text.length < 25 &&
            !text.contains(RegExp(r'[0-9]'))) {
          // Name should be between 3-25 characters and should not contain numbers
        }
      }

      if (panNumber != null || dob != null) {
        setState(() {
          if (panNumber != null) {
            _panNumber = panNumber;
            _panController.text = _panNumber!;
          }
          if (dob != null) {
            _dob = dob;
            _dobController.text = _dob!;
          }
        });
      }
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      textRecognizer.close();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload PAN Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _panImage != null
                      ? Image.file(_panImage!, height: 200, width: 200)
                      : Container(
                          height: 200.0,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                            child: Icon(Icons.image,
                                size: 50.0, color: Colors.grey),
                          ),
                        ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        child: const Text('Gallery',
                            style: TextStyle(fontSize: 15)),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.camera),
                        child: const Text('Camera',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                // Non-editable
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _panController,
                decoration: const InputDecoration(
                  labelText: 'PAN Number',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Non-editable
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Non-editable
              ),
              const SizedBox(height: 16.0),
              PrimaryButton(
                onPressed: (){},
                context: context,
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
