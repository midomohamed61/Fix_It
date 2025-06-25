import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool general = true;
  bool sound = false;
  bool vibrate = true;
  bool newService = false;
  bool payment = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    general = await SharedPrefHelper.getBool('notif_general') ?? true;
    sound = await SharedPrefHelper.getBool('notif_sound') ?? false;
    vibrate = await SharedPrefHelper.getBool('notif_vibrate') ?? true;
    newService = await SharedPrefHelper.getBool('notif_newService') ?? false;
    payment = await SharedPrefHelper.getBool('notif_payment') ?? true;
    setState(() {});
  }

  Future<void> _savePrefs() async {
    await SharedPrefHelper.setData('notif_general', general);
    await SharedPrefHelper.setData('notif_sound', sound);
    await SharedPrefHelper.setData('notif_vibrate', vibrate);
    await SharedPrefHelper.setData('notif_newService', newService);
    await SharedPrefHelper.setData('notif_payment', payment);
    if (mounted) Navigator.pop(context);
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          ),
        ],
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
        title: const Text('Notification', style: TextStyle(color: AppColors.primaryColor)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSwitchTile('General notification', general, (v) => setState(() => general = v)),
            _buildSwitchTile('Sound', sound, (v) => setState(() => sound = v)),
            _buildSwitchTile('Vibrate', vibrate, (v) => setState(() => vibrate = v)),
            _buildSwitchTile('New Service', newService, (v) => setState(() => newService = v)),
            _buildSwitchTile('Payment', payment, (v) => setState(() => payment = v)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _savePrefs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 