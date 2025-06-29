import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'filter_screen.dart';
import 'popular_services_screen.dart';
import 'all_workers_screen.dart';
import 'worker_profile_screen.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _searchSuggestions = [];
  bool _showSuggestions = false;
  String? _selectedJob;

  @override
  void initState() {
    super.initState();
    // لا داعي لأي Bloc هنا
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // خدمات شائعة ثابتة
  List<Map<String, dynamic>> getPopularServices() {
    return [
      {'icon': Icons.plumbing, 'label': 'Plumbing'},
      {'icon': Icons.electrical_services, 'label': 'Electric work'},
      {'icon': Icons.solar_power, 'label': 'Solar'},
    ];
  }

  Map<String, List<Map<String, dynamic>>> getPopularServicesCategories() {
    return {
      'Maintenance': [
        {'icon': Icons.ac_unit, 'label': 'Air Condition'},
        {'icon': Icons.electrical_services, 'label': 'Electric'},
        {'icon': Icons.build, 'label': 'Sliding repair'},
      ],
      'Cleaning': [
        {'icon': Icons.cleaning_services, 'label': 'Home Flooring'},
        {'icon': Icons.local_laundry_service, 'label': 'Outher'},
        {'icon': Icons.carpenter, 'label': 'Carpet'},
      ],
      'Home Improvement': [
        {'icon': Icons.construction, 'label': 'Drilling'},
        {'icon': Icons.grass, 'label': 'Lawn'},
        {'icon': Icons.nature, 'label': 'Weed control'},
      ],
      'Security': [
        {'icon': Icons.videocam, 'label': 'Camera'},
        {'icon': Icons.security, 'label': 'Burglar alarm'},
        {'icon': Icons.lock, 'label': 'Sturdy lock'},
      ],
      'Car Maintenance': [
        {'icon': Icons.local_car_wash, 'label': 'Car washer'},
        {'icon': Icons.oil_barrel, 'label': 'Oil change'},
        {'icon': Icons.battery_charging_full, 'label': 'Car battery'},
      ],
      'Handyman Services': [
        {'icon': Icons.chair, 'label': 'Furniture'},
        {'icon': Icons.door_front_door, 'label': 'Door'},
        {'icon': Icons.handyman, 'label': 'Shelving'},
      ],
      'Painting Services': [
        {'icon': Icons.format_paint, 'label': 'Interior'},
        {'icon': Icons.format_paint_outlined, 'label': 'Wall'},
      ],
      'Other services': [
        {'icon': Icons.wash, 'label': 'Dish wash'},
        {'icon': Icons.local_shipping, 'label': 'Loading'},
        {'icon': Icons.cut, 'label': 'Cutting'},
      ],
    };
  }

  // Helper to flatten all services from all categories
  List<Map<String, dynamic>> getAllPopularServicesFlat() {
    final categories = getPopularServicesCategories();
    return categories.values.expand((list) => list).toList();
  }

  Color getWorkerCardColor(int i) {
    final bgColors = [Color(0xFFE3F0FF), Color(0xFFFFE3F0), Color(0xFFF0FFE3), Color(0xFFFFF7E3)];
    return bgColors[i % bgColors.length];
  }

  // قائمة عمال وهميين
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Image.asset('assets/images/Frame.png', height: 32),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1566C2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Get 30% off",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Just by Booking Home Services",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Search with suggestions
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                          _showSuggestions = value.isNotEmpty;
                        });
                      },
                      onTap: () {
                        if (_searchQuery.isNotEmpty) {
                          setState(() {
                            _showSuggestions = true;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search here..",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      final selectedJob = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FilterScreen(
                            availableJobs: ['Electrician', 'Plumber', 'Carpenter', 'Painter', 'Cleaner', 'Technician', 'Mechanic', 'Designer'],
                            selectedJob: _selectedJob,
                          ),
                        ),
                      );
                      if (selectedJob != null) {
                        setState(() {
                          _selectedJob = selectedJob;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              
              // Search suggestions
              if (_showSuggestions && _searchSuggestions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _searchSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _searchSuggestions[index];
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.search, size: 16, color: Colors.grey),
                        title: Text(
                          suggestion,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          // Popular Services
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Popular Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PopularServicesScreen(
                        categories: getPopularServicesCategories(),
                      ),
                    ),
                  );
                },
                child: const Text("View all", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Horizontal row for popular services
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: getAllPopularServicesFlat().length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, i) {
                final service = getAllPopularServicesFlat()[i];
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue[50],
                      child: Icon(service['icon'], color: Colors.blue, size: 32),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['label'],
                      style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Service Providers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Service Providers", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    children: [
                      Text(
                        '15 workers available',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_searchQuery.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          'for "$_searchQuery"',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AllWorkersScreen(),
                    ),
                  );
                },
                child: const Text("View all", style: TextStyle(color: AppColors.primaryColor)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Workers Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: getFakeWorkers().length,
            itemBuilder: (context, i) {
              final p = getFakeWorkers()[i];
              final bgColor = getWorkerCardColor(i);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkerProfileScreen(
                        name: p.name,
                        jobTitle: p.jobTitle,
                        rate: p.rate,
                        imageUrl: i < 4 ? p.imageUrl : null,
                        price: p.price,
                        availability: p.availability,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
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
                      const SizedBox(height: 12),
                      Text(
                        p.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.jobTitle,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(80, 32),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Details", style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 