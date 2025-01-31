import 'dart:io';
import 'package:appl_f/common/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../common/api_helper.dart';
import '../common/common_toast.dart';
import '../common/primary_button.dart';
import '../common/success_dialog.dart';
import '../main.dart';
import '../utils/common_util.dart';
import '../utils/constants.dart';
import '../utils/session_helper.dart';

class UploadAadhaarScreen extends StatefulWidget {
  const UploadAadhaarScreen({super.key});

  @override
  UploadAadhaarScreenState createState() => UploadAadhaarScreenState();
}

class UploadAadhaarScreenState extends State<UploadAadhaarScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _aadhaarFrontImage;
  File? _aadhaarBackImage;
  String? _aadhaarNumber;
  String? _address;
  String? _dob;
  var isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  get type => 'aadhar';

  void dispose() {
    _aadhaarController.dispose();
    _dobController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> submitAadharApi() async {
    if (_nameController.text.isEmpty) {
      // showSnackBar("Enter Username");
    } else if (_aadhaarController.text.isEmpty) {
    }
    else if (_dobController.text.isEmpty) {
      // showSnackBar("Enter Date Of Birth");
    } else {
      setState(() {
        isLoading = true;
      });
      closeKeyboard(context);
      var userId = await SessionHelper.getSessionData(SessionKeys.userId);

      final response = await ApiHelper.postRequest(
        url: baseUrl + submitAadhar,
        body: {
          'user_id':userId ,
          'validation_type': type,
          'validation_no': _aadhaarController.text,
          'customer_name': _nameController.text,
          'dob': _dobController.text,
          'address': _addressController.text,
          'document_string': _aadhaarFrontImage.toString(),
          'document_string2': _aadhaarBackImage.toString(),
        },
      );

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });

      if (response['error'] == true) {
        CommonToast.showToast(
          context: context,
          title: "Aadhar Upload Failed",
          description: response['message'],
        );
      } else {
        final data = response;
        print(data);
        if (data['status'] == 0) {
          CommonToast.showToast(
              context: context,
              title: "Aadhar Upload Failed",
              description: data['response'].toString(),
              duration: const Duration(seconds: 10));
        } else {
          showSuccessDialog(context, "Submit Aadhar", duration: 5, onDismiss: () {
            Navigator.of(context).pop();
          });
        }
      }
    }
  }

  Future<void> _pickImage(ImageSource source, {required bool isFront}) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _aadhaarFrontImage = File(pickedFile.path);
          _processImage(_aadhaarFrontImage!);
        } else {
          _aadhaarBackImage = File(pickedFile.path);
          _processImage(_aadhaarBackImage!);
        }
      });
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
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      List<String> lines = recognizedText.text.split('\n');

      for (String text in lines) {
        text = text.trim();

        if (RegExp(r'^\d{4}\s\d{4}\s\d{4}$').hasMatch(text)) {
          setState(() {
            _aadhaarNumber = text;
            _aadhaarController.text = _aadhaarNumber!;
          });
        } else if (RegExp(r'\b(0[1-9]|[12][0-9]|3[01])[-/](0[1-9]|1[0-2])[-/](19|20)\d\d\b').hasMatch(text)) {
          setState(() {
            _dob = text;
            _dobController.text = _dob!;
          });
        } else if (text.length > 10) {
          setState(() {
            _address = text;
            _addressController.text = _address!;
          });
        }
      }
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      textRecognizer.close();
    }
  }




  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar(title: 'Upload Aadhar Card', size: size),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _aadhaarFrontImage != null
                      ? Image.file(_aadhaarFrontImage!, height: 130, width: 200)
                      : Container(
                    height: 150.0,
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
                        onPressed: () => _pickImage(ImageSource.gallery, isFront: true),
                        child: const Text('Gallery'),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.camera, isFront: true),
                        child: const Text('Camera'),
                      ),

                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _aadhaarBackImage != null
                      ? Image.file(_aadhaarBackImage!, height: 130, width: 200)
                      : Container(
                    height: 150.0,
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
                        onPressed: () => _pickImage(ImageSource.gallery, isFront: false),
                        child: const Text('Gallery'),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.camera, isFront: false),
                        child: const Text('Camera'),
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
                controller: _aadhaarController,
                decoration: const InputDecoration(
                  labelText: 'Aadhar Number',
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
                ), // Non-editable
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                 // Non-editable
              ),
              const SizedBox(height: 16.0),
              PrimaryButton(
                onPressed: (){submitAadharApi();},
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
