import 'dart:io';

import 'package:appl_f/common/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/primary_button.dart';

class UploadAadarScreen extends StatefulWidget {
  const UploadAadarScreen({super.key});

  @override
  State<UploadAadarScreen> createState() => _UploadAadhaarScreenState();
}

class _UploadAadhaarScreenState extends State<UploadAadarScreen> {
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
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
                    child: _backImage != null
                        ? Image.file(
                      _backImage!,
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

            const TextField(
              decoration: InputDecoration(
                labelText: 'Aadhaar Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),

            // Customer Name
            const TextField(
              decoration: InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Date of Birth
            TextField(
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () {
                // Handle date picker
              },
            ),
            const SizedBox(height: 16.0),

            // Address
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),

            PrimaryButton(onPressed:(){} , context: context,text: 'Save',)
          ],
        ),
      ),
    );
  }
}
