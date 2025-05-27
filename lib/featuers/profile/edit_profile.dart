import 'package:flutter/material.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    _nameController.text = await SharedPrefHelper.getString('userName') ?? '';
    _emailController.text = await SharedPrefHelper.getString('userEmail') ?? '';
    _dobController.text = await SharedPrefHelper.getString('userDob') ?? '';
    _phoneController.text = await SharedPrefHelper.getString('userPhone') ?? '';
    _selectedCountry = await SharedPrefHelper.getString('userCountry') ?? 'Egypt';
    setState(() {});
  }

  Future<void> _saveProfile() async {
  if (_formKey.currentState!.validate()) {
    await SharedPrefHelper.setData('userName', _nameController.text);
    await SharedPrefHelper.setData('userEmail', _emailController.text);
    await SharedPrefHelper.setData('userDob', _dobController.text);
    await SharedPrefHelper.setData('userPhone', _phoneController.text);
    await SharedPrefHelper.setData('userCountry', _selectedCountry);

    if (mounted) {
      Navigator.pop(context, true); // return success to previous screen
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(radius: 48),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    )
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
                onPressed: _saveProfile,
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
        items: ['Egypt', 'Mexico', 'USA', 'UK']
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
