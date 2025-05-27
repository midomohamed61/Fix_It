import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery", style: TextStyle(color:AppColors.textColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/ProviderProfileScreen');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 الصور في كل صف
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 6, // عدد الصور
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/image 84.png'), // استبدل بمسار الصورة الفعلي
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
