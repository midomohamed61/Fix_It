import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية
    final String workerName = 'Jackson';
    final String greeting = 'Welcome Back!';
    final double totalEarning = 1259;
    final int totalService = 1589;
    final int upcomingServices = 15;
    final int todaysService = 5;
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Donna Bins',
        'avatar': 'assets/images/worker2.png',
        'date': '02 Dec',
        'rating': 4.5,
        'comment': 'Very good'
      },
      {
        'name': 'Jackson',
        'avatar': 'assets/images/worker3.png',
        'date': '25 Jan',
        'rating': 4.5,
        'comment': 'thnks alot.'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello $workerName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(greeting, style: const TextStyle(fontSize: 15, color: Colors.black54)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('₹$totalEarning', 'Total Earning', Icons.account_balance_wallet_outlined),
                  _buildStatCard('$totalService', 'Total Service', Icons.miscellaneous_services),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('$upcomingServices', 'Upcoming Services', Icons.event_available),
                  _buildStatCard('$todaysService', "Today's Service", Icons.today),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All', style: TextStyle(color: AppColors.primaryColor)),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final r = reviews[i];
                    return _buildReviewTile(r);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 28),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryColor)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewTile(Map<String, dynamic> r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(r['avatar']),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(r['date'], style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
              Row(
                children: [
                  ...List.generate(5, (i) => Icon(Icons.star, size: 14, color: i < r['rating'].floor() ? Colors.amber : Colors.grey[300])),
                  if (r['rating'] - r['rating'].floor() >= 0.5) Icon(Icons.star_half, size: 14, color: Colors.amber),
                  const SizedBox(width: 6),
                  Text(r['rating'].toString(), style: const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 4),
              Text(r['comment'], style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
} 