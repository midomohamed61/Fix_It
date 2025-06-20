import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/review_model/review_model.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/widget/gallery_list.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/widget/info_card.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/widget/review_tile.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/widget/skill_chip_list.dart';
import 'package:url_launcher/url_launcher.dart';
class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({super.key});

  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  // Load the favorite status from SharedPreferences
  Future<void> _loadFavoriteStatus() async {
    final favoriteStatus = await SharedPrefHelper.getBool('isFavorite');
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  // Handle the favorite icon click
  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });
    await SharedPrefHelper.setData('isFavorite', isFavorite);
  }

  // Handle the call icon click
  void _makeCall() async {
  final phone = 'tel:+1234567890'; // Replace with actual phone number
  if (await canLaunchUrl(Uri.parse(phone))) {
    await launchUrl(Uri.parse(phone));
    Navigator.pushReplacementNamed(context, '/CallScreen');
  } else {
    throw 'Could not launch $phone';
  }
}

  @override
  Widget build(BuildContext context) {
    final List<String> skills = ['Sink', 'Shower', 'Boiler', 'Toilet'];

    final List<Review> reviews = [
      Review(image: 'assets/images/Rectangle 2117.png' ,reviewerName: 'Josh Peter', date: '12/12/2024', comment: 'Emily Jani exceeded my expectations! Quick, reliable, and fixed my plumbing issue with precision. Highly recommend.'),
      Review( image: 'assets/images/Rectangle 2117.png', reviewerName: 'Caleb', date: '11/12/2024', comment: 'Emily Jani exceeded my expectations! Quick, reliable, and fixed my plumbing issue with precision. Highly recommend.'),
      Review( image: 'assets/images/Rectangle 2117.png', reviewerName: 'Ethan', date: '10/12/2024', comment: 'Emily Jani exceeded my expectations! Quick, reliable, and fixed my plumbing issue with precision. Highly recommend.'),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/image 84.png'),
            ),
            const SizedBox(height: 10),
            const Text('Emily Jani', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textColor)),
            const Text('Plumber', style: TextStyle(color: AppColors.greyTextColor)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const InfoCard(icon: Icons.star, value: '4.8', label: 'Rating'),
                const InfoCard(icon: Icons.assignment_turned_in, value: '56', label: 'Orders'),
                const InfoCard(icon: Icons.work, value: '4 Years', label: 'Experience'),
              ],
            ),
            const SizedBox(height: 16),
            // Worker Info with Call and Favorite Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Emily Jani', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                Row(
                  children: [
                    IconButton(
                      onPressed: _makeCall,
                      icon: const Icon(Icons.phone, color: AppColors.primaryColor),
                    ),
                    IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textColor)),
            ),
            const SizedBox(height: 8),
            SkillChipList(skills: skills),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle book button press
                  Navigator.pushReplacementNamed(context, '/LocationPermissionScreen');
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                child: const Text('Book', style: TextStyle(color: AppColors.backgroundColor)),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Bio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textColor)),
            ),
            const SizedBox(height: 8),
            const Text(
              "I'm Emily Jani, a dedicated plumbing professional with a passion for delivering top notch service to ensure your home’s plumbing runs smoothly. With years of hands-on experience.",
              style: TextStyle(color: AppColors.textColor),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textColor)),
                TextButton(onPressed: () {
                  Navigator.pushReplacementNamed(context, '/GalleryScreen');
                }, child: const Text('View all')),
              ],
            ),
            const GalleryList(),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textColor)),
            ),
            const SizedBox(height: 8),
            ...reviews.map((review) => ReviewTile(review: review)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
