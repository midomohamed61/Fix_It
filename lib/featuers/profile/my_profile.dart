import 'package:flutter/material.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/routing/routes.dart'; // تأكد من إضافة هذا السطر

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                onTap: () => _showComingSoon(context),
              ),
              _buildProfileOption(
                icon: Icons.notifications,
                title: "Notification",
                onTap: () => _showComingSoon(context),
              ),
              _buildProfileOption(
                icon: Icons.payment,
                title: "Payment method",
                onTap: () => _showComingSoon(context),
              ),
              _buildProfileOption(
                icon: Icons.help,
                title: "Help & support",
                onTap: () => _showComingSoon(context),
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
                    border: Border.all(color: Colors.red),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "🔄 Change Profile to selling mode",
                style: TextStyle(
                  color: AppColors.greyTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              FutureBuilder<String?>(
                future: SharedPrefHelper.getString('userName'),
                builder: (context, snapshot) {
                  final userName = snapshot.data ?? 'User';
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
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
    Navigator.pushNamed(context, Routes.EditProfileScreen);
  }

  void _handleLogout(BuildContext context) async {
    await SharedPrefHelper.removeData('userToken');
    await SharedPrefHelper.removeData('userName');

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.SigninScreen,
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out")),
    );
  }
}
