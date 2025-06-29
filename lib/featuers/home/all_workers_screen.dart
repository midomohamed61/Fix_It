import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/home/worker_profile_screen.dart';

// تعريف كلاس وهمي للعمال
class FakeWorker {
  final String name;
  final String jobTitle;
  final double rate;
  final String imageUrl;
  final double price; // السعر بالساعة
  final String availability; // المواعيد المتاحة
  FakeWorker({
    required this.name, 
    required this.jobTitle, 
    required this.rate, 
    required this.imageUrl,
    required this.price,
    required this.availability,
  });
}

List<FakeWorker> getFakeWorkers() {
  final List<String> names = [
    'Jackson', 'Logan', 'Ethan Ilta', 'Isabella Una', 'Panama', 'Jamalo', 'Meharn', 'Shatem',
    'Liam', 'Olivia', 'Noah', 'Emma', 'Ava', 'Mason', 'Sophia'
  ];
  final List<String> jobs = [
    'Electrician', 'Plumber', 'Carpenter', 'Painter', 'Cleaner', 'Technician', 'Mechanic', 'Designer',
    'Electrician', 'Plumber', 'Carpenter', 'Painter', 'Cleaner', 'Technician', 'Mechanic'
  ];
  final List<double> rates = [4.9, 5.0, 4.4, 4.3, 4.9, 4.7, 4.8, 4.5, 4.6, 4.2, 4.1, 4.0, 4.3, 4.7, 4.8];
  final List<double> prices = [75.0, 80.0, 65.0, 70.0, 60.0, 85.0, 90.0, 55.0, 75.0, 70.0, 65.0, 80.0, 85.0, 90.0, 75.0];
  final List<String> availability = [
    '9:00 AM - 6:00 PM', '8:00 AM - 5:00 PM', '10:00 AM - 7:00 PM', '9:00 AM - 6:00 PM',
    '8:00 AM - 5:00 PM', '10:00 AM - 7:00 PM', '9:00 AM - 6:00 PM', '8:00 AM - 5:00 PM',
    '10:00 AM - 7:00 PM', '9:00 AM - 6:00 PM', '8:00 AM - 5:00 PM', '10:00 AM - 7:00 PM',
    '9:00 AM - 6:00 PM', '8:00 AM - 5:00 PM', '10:00 AM - 7:00 PM'
  ];
  
  // استخدام الصور الموجودة فقط مع تكرارها
  final List<String> availableImages = [
    'assets/images/worker1.png',
    'assets/images/worker2.png', 
    'assets/images/worke3.png',
  ];
  
  return List.generate(15, (i) => FakeWorker(
    name: names[i],
    jobTitle: jobs[i],
    rate: rates[i],
    imageUrl: availableImages[i % availableImages.length], // تكرار الصور المتاحة
    price: prices[i],
    availability: availability[i],
  ));
}

Color getWorkerCardColor(int i) {
  final bgColors = [Color(0xFFE3F0FF), Color(0xFFFFE3F0), Color(0xFFF0FFE3), Color(0xFFFFF7E3)];
  return bgColors[i % bgColors.length];
}

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workers = getFakeWorkers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Workers'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: workers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final p = workers[i];
          final bgColor = getWorkerCardColor(i);
          return Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 36, color: Colors.grey[400]),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.jobTitle,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            p.rate.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${p.price.toStringAsFixed(0)}/hour',
                        style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.availability,
                        style: const TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerProfileScreen(
                          name: p.name,
                          jobTitle: p.jobTitle,
                          rate: p.rate,
                          imageUrl: p.imageUrl,
                          price: p.price,
                          availability: p.availability,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(80, 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Details", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 