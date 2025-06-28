import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/repos/profile_repo.dart';
import 'package:fix_it/core/models/profile/profile_response.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/networking/api_result.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountry = 'Egypt';
  final List<String> _countries = ['Egypt', 'Mexico', 'USA', 'UK'];
  File? _profileImage;
  String? _userId;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndData();
  }

  Future<void> _loadUserIdAndData() async {
    setState(() => _loading = true);
    _userId = await SharedPrefHelper.getString('userId');
    if (_userId != null) {
      await _loadUserDataFromApi(_userId!);
    }
    setState(() => _loading = false);
  }

  Future<void> _loadUserDataFromApi(String userId) async {
    final repo = getIt<ProfileRepo>();
    final result = await repo.getProfile(userId);
    if (result is Success<ProfileResponse>) {
      final user = result.data;
      _nameController.text = user.name;
      _emailController.text = user.email;
      // إذا أضفت حقول dob, phone, country في الـ API أضفها هنا
      // _dobController.text = user.dob ?? '';
      // _phoneController.text = user.phone ?? '';
      // _selectedCountry = user.country ?? 'Egypt';
      // صورة البروفايل من user.imageUrl إذا أردت
      setState(() {});
    }
  }

  Future<void> _saveProfileToApi() async {
    if (_formKey.currentState!.validate() && _userId != null) {
      setState(() => _loading = true);
      final repo = getIt<ProfileRepo>();
      final body = {
        'name': _nameController.text,
        'email': _emailController.text,
        // أضف الحقول الأخرى إذا كانت مدعومة في الـ API
        // 'dob': _dobController.text,
        // 'phone': _phoneController.text,
        // 'country': _selectedCountry,
      };
      final result = await repo.updateProfile(_userId!, body);
      setState(() => _loading = false);
      if (result is Success) {
        if (mounted) Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // يمكنك هنا رفع الصورة للـ API إذا كان مدعومًا
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Edit Profile", style: TextStyle(color: AppColors.primaryColor)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage('assets/images/profile.png') as ImageProvider,
                          ),
                          GestureDetector(
                            onTap: _showImageSourceDialog,
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(Icons.edit, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(controller: _nameController, label: 'Name'),
                    _buildTextField(controller: _emailController, label: 'Email'),
                    _buildTextField(
                      controller: _dobController,
                      label: 'Date of Birth',
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    ),
                    _buildDropdown(),
                    _buildTextField(controller: _phoneController, label: 'Phone number'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveProfileToApi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedCountry,
        items: _countries
            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
            .toList(),
        onChanged: (val) => setState(() => _selectedCountry = val ?? 'Egypt'),
        decoration: InputDecoration(
          labelText: 'Country',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
