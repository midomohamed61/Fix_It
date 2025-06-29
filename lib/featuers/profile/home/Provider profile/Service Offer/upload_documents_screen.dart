import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/profile/home/Provider profile/Service Offer/select_payment_method_screen.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  XFile? licenseFile;
  XFile? certFile;
  XFile? profileFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile(String type) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (type == 'license') {
          licenseFile = picked;
        } else if (type == 'cert') {
          certFile = picked;
        } else if (type == 'profile') {
          profileFile = picked;
        }
      });
    }
  }

  Future<void> _saveFiles() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('licenseFile', licenseFile?.path ?? '');
    await prefs.setString('certFile', certFile?.path ?? '');
    await prefs.setString('profileFile', profileFile?.path ?? '');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Documents saved locally!')));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectPaymentMethodScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Image.asset('assets/images/Frame.png', height: 30),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.more_horiz, color: Colors.blue[900]),
                Icon(Icons.more_horiz, color: Colors.blue[900]),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('We need a few Documents.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Upload your services license', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _pickFile('license'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload, color: AppColors.primaryColor),
                  const SizedBox(width: 8),
                  Text(licenseFile == null ? '+ Upload' : 'Uploaded', style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Upload your Certification', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _pickFile('cert'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload, color: AppColors.primaryColor),
                  const SizedBox(width: 8),
                  Text(certFile == null ? '+ Upload' : 'Uploaded', style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Upload your Profile Picture', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _pickFile('profile'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload, color: AppColors.primaryColor),
                  const SizedBox(width: 8),
                  Text(profileFile == null ? '+ Upload' : 'Uploaded', style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveFiles,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1566C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 