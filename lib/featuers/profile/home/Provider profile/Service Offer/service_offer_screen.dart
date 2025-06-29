import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/profile/home/Provider profile/Service Offer/upload_documents_screen.dart';

class ServiceOfferScreen extends StatefulWidget {
  final String name;
  final String jobTitle;
  final double rate;
  final String? imageUrl;
  final double price;
  final String availability;
  final String businessName;
  final String businessAddress;
  const ServiceOfferScreen({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.rate,
    this.imageUrl,
    required this.price,
    required this.availability,
    required this.businessName,
    required this.businessAddress,
  });

  @override
  State<ServiceOfferScreen> createState() => _ServiceOfferScreenState();
}

class _ServiceOfferScreenState extends State<ServiceOfferScreen> {
  String? selectedService;
  String? selectedExperience;
  String? selectedArea;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String amPm = 'AM';

  final List<String> services = [
    'Electrician', 'Plumber', 'Carpenter', 'Painter', 'Cleaner', 'Technician', 'Mechanic', 'Designer'
  ];
  final List<String> experiences = [
    'Less than 1 year', '1-3 years', '3-5 years', '5+ years'
  ];
  final List<String> areas = [
    'Cairo', 'Giza', 'Alexandria', 'Other'
  ];

  Future<void> _pickTime(bool isFrom) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('service', selectedService ?? '');
    await prefs.setString('experience', selectedExperience ?? '');
    await prefs.setString('area', selectedArea ?? '');
    await prefs.setString('fromTime', fromTime?.format(context) ?? '');
    await prefs.setString('toTime', toTime?.format(context) ?? '');
    await prefs.setString('amPm', amPm);
    await prefs.setString('businessName', widget.businessName);
    await prefs.setString('businessAddress', widget.businessAddress);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data saved locally!')));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UploadDocumentsScreen(),
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
            const Text('Service offer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: selectedService,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Your service',
              ),
              items: services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => selectedService = v),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedExperience,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Your Experience',
              ),
              items: experiences.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => selectedExperience = v),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedArea,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Service Area',
              ),
              items: areas.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => selectedArea = v),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickTime(true),
                    child: Text(fromTime == null ? 'From' : fromTime!.format(context)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickTime(false),
                    child: Text(toTime == null ? 'To' : toTime!.format(context)),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: amPm,
                  items: ['AM', 'PM'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => amPm = v!),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveData,
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