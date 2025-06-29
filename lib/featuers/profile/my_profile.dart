import 'package:flutter/material.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/routing/routes.dart'; // تأكد من إضافة هذا السطر

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 12),

              FutureBuilder<String?>(
                future: SharedPrefHelper.getString('userName'),
                builder: (context, snapshot) {
                  final userName = snapshot.data ?? 'Mahrama';
                  return Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              _buildProfileOption(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () async {
                  final result = await Navigator.pushNamed(context, Routes.EditProfileScreen);
                  if (result == true && mounted) setState(() {});
                },
              ),
              _buildProfileOption(
                icon: Icons.notifications_none,
                title: "Notification",
                onTap: () => Navigator.pushNamed(context, Routes.NotificationScreen),
              ),
              _buildProfileOption(
                icon: Icons.credit_card,
                title: "Payment method",
                onTap: () => Navigator.pushNamed(context, Routes.PaymentMethodScreen),
              ),
              _buildProfileOption(
                icon: Icons.help_outline,
                title: "Help & support",
                onTap: () => Navigator.pushNamed(context, Routes.HelpSupportScreen),
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: () => _handleLogout(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: AppColors.primaryColor),
                      SizedBox(width: 8),
                      Text("Logout", style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.sync_alt, color: AppColors.primaryColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Change Profile to selling mode",
                    style: TextStyle(
                      color: AppColors.greyTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              FutureBuilder<String?>(
                future: SharedPrefHelper.getString('userName'),
                builder: (context, snapshot) {
                  final userName = snapshot.data ?? 'Mahrama';
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(
          title,
          style: const TextStyle(color: AppColors.textColor),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.greyTextColor),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Coming soon!")),
    );
  }

  void _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logout.png', width: 79, height: 87),
              const SizedBox(height: 16),
              const Text(
                'Are you sure to logout?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    await SharedPrefHelper.removeData('userToken');
                    await SharedPrefHelper.removeData('userName');
                    Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.SigninScreen,
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out")),
                    );
                  },
                  child: const Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Text('Cancel', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
