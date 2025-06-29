import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/profile/home/Provider profile/Location Permission/location_permission_screen.dart';

class WorkerProfileScreen extends StatelessWidget {
  final String name;
  final String jobTitle;
  final double rate;
  final String? imageUrl;
  final double price; // السعر بالساعة
  final String availability; // المواعيد المتاحة
  const WorkerProfileScreen({
    super.key, 
    required this.name, 
    required this.jobTitle, 
    required this.rate, 
    this.imageUrl,
    required this.price,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية ثابتة
    final List<String> skills = ['Sink', 'Shower', 'Boiler', 'Toilet'];
    final int orders = 56;
    final int experience = 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              if (imageUrl != null)
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 60, color: Colors.grey[400]),
                    ),
                  ),
                ),
              if (imageUrl != null) const SizedBox(height: 16),
              // اسم العامل
              Text(
                name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              // الوظيفة
              Text(
                jobTitle,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              // التقييم + عدد الطلبات + سنوات الخبرة
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      const SizedBox(height: 4),
                      Text('${rate.toStringAsFixed(1)}\nRating', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 28),
                  Column(
                    children: [
                      Icon(Icons.assignment_turned_in, color: Colors.green, size: 22),
                      const SizedBox(height: 4),
                      Text('$orders\nOrders', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 28),
                  Column(
                    children: [
                      Icon(Icons.workspace_premium, color: Colors.purple, size: 22),
                      const SizedBox(height: 4),
                      Text('$experience\nYears', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // السعر والمواعيد
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price per hour',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              '\$${price.toStringAsFixed(0)}',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Availability',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              availability,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Skills
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: skills.map((s) => Chip(label: Text(s))).toList(),
              ),
              const SizedBox(height: 30),
              // Gallery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/GalleryScreen');
                    },
                    child: const Text('View all', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/worker1.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // زر Book
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LocationPermissionScreen(
                          name: name,
                          jobTitle: jobTitle,
                          rate: rate,
                          imageUrl: imageUrl,
                          price: price,
                          availability: availability,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Book', style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 