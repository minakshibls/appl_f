import 'dart:io';

import 'package:appl_f/common/default_app_bar.dart';
import 'package:appl_f/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPanScreen extends StatefulWidget {
  const UploadPanScreen({super.key});

  @override
  State<UploadPanScreen> createState() => _UploadPanScreenState();
}

class _UploadPanScreenState extends State<UploadPanScreen> {
  File? _frontImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront)
        {
          _frontImage = File(pickedFile.path);
          // Example data for demonstration
          _panController.text = "ABCDE1234F";
          _customerNameController.text = "John Doe";
          _dobController.text = "01/01/1990";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar(title: 'Upload Pan', size: size),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PAN Image',
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
                    child: _frontImage != null
                        ? Image.file(
                      _frontImage!,
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

            TextField(
              controller: _panController,
              decoration: const InputDecoration(
                labelText: 'PAN Number',
                border: OutlineInputBorder(),
              ),
              enabled: false, // Non-editable
            ),
            const SizedBox(height: 16.0),

            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
              enabled: false, // Non-editable
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              enabled: false, // Non-editable
            ),

            const SizedBox(height: 24.0),

            PrimaryButton(
              onPressed: () {
                // Handle save action
              },
              context: context,
              text: 'Save',
            )
          ],
        ),
      ),
    );
  }
}
