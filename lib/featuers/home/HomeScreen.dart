import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'filter_screen.dart';
import 'popular_services_screen.dart';
import 'package:fix_it/core/models/worker/worker_response.dart';
import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/repos/customer_repo.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/helpers/constants.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/dio_factory.dart';
import 'package:dio/dio.dart';
import 'all_workers_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/workers_cubit.dart';

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
    // اطلب تحميل العمال عند بناء الصفحة
    Future.microtask(() => context.read<WorkersCubit>().fetchWorkers());
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

  // Helper to get all job titles from loaded providers
  List<String> _getAllJobsFromProviders(List<WorkerResponse> workers) {
    return workers.map((w) => w.jobTitle).toSet().toList();
  }

  // فلترة العاملين (تعمل الآن مع WorkerResponse)
  List<WorkerResponse> filterWorkers(List<WorkerResponse> workers, String query) {
    var filtered = workers;
    if (_selectedJob != null && _selectedJob!.isNotEmpty) {
      filtered = filtered.where((w) => w.jobTitle == _selectedJob).toList();
    }
    if (query.isEmpty) return filtered;
    final lowercaseQuery = query.toLowerCase().trim();
    return filtered.where((worker) {
      final nameMatch = worker.name.toLowerCase().contains(lowercaseQuery);
      final jobMatch = worker.jobTitle.toLowerCase().contains(lowercaseQuery);
      return nameMatch || jobMatch;
    }).toList();
  }

  // اقتراحات البحث (تعمل الآن مع WorkerResponse)
  void generateSearchSuggestions(List<WorkerResponse> workers) {
    if (_searchQuery.isEmpty) {
      _searchSuggestions = [];
      return;
    }
    final suggestions = <String>{};
    final lowercaseQuery = _searchQuery.toLowerCase();
    for (final worker in workers) {
      if (worker.name.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(worker.name);
      }
      if (worker.jobTitle.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(worker.jobTitle);
      }
    }
    final commonJobs = [
      'Plumber', 'Electrician', 'Carpenter', 'Painter', 'Cleaner',
      'Gardener', 'Mechanic', 'Technician', 'Engineer', 'Designer'
    ];
    for (final job in commonJobs) {
      if (job.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(job);
      }
    }
    setState(() {
      _searchSuggestions = suggestions.take(8).toList();
    });
  }

  // تطبيق اقتراح البحث
  void applySuggestion(String suggestion) {
    _searchController.text = suggestion;
    setState(() {
      _searchQuery = suggestion;
      _showSuggestions = false;
    });
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

  // جلب مزودي الخدمة من الـ API
  Future<List<WorkerResponse>> fetchServiceProviders() async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token != null && token.isNotEmpty) {
        DioFactory.setTokenIntoHeaderAfterLogin(token);
      }
      final customerRepo = getIt<CustomerRepo>();
      final result = await customerRepo.findWorkers();
      if (result is Success<List<WorkerResponse>>) {
        return result.data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<WorkersCubit>(context),
      child: Scaffold(
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
                          final workers = (context.read<WorkersCubit>().state is WorkersLoaded)
                              ? (context.read<WorkersCubit>().state as WorkersLoaded).workers
                              : <WorkerResponse>[];
                          generateSearchSuggestions(workers);
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
                        final workers = (context.read<WorkersCubit>().state is WorkersLoaded)
                            ? (context.read<WorkersCubit>().state as WorkersLoaded).workers
                            : <WorkerResponse>[];
                        final selectedJob = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FilterScreen(
                              availableJobs: _getAllJobsFromProviders(workers),
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
                          onTap: () => applySuggestion(suggestion),
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
                    BlocBuilder<WorkersCubit, WorkersState>(
                      builder: (context, state) {
                        List<WorkerResponse> workers = [];
                        if (state is WorkersLoaded) workers = state.workers;
                        final filtered = filterWorkers(workers, _searchQuery);
                        return Row(
                          children: [
                            Text(
                              '${filtered.length} workers available',
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
                        );
                      },
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
            BlocBuilder<WorkersCubit, WorkersState>(
              builder: (context, state) {
                if (state is WorkersLoading) {
                  return Container(
                    height: 180,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is WorkersError) {
                  return Container(
                    height: 120,
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is WorkersLoaded) {
                  final filteredProviders = filterWorkers(state.workers, _searchQuery);
                  if (filteredProviders.isEmpty && _searchQuery.isNotEmpty) {
                    return Container(
                      height: 120,
                      child: Center(child: Text('No workers found for "$_searchQuery"')),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, i) {
                      final p = filteredProviders[i];
                      final bgColor = getWorkerCardColor(i);
                      return Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              backgroundImage: (p.imageUrl != null && p.imageUrl!.isNotEmpty)
                                  ? NetworkImage(p.imageUrl!)
                                  : null,
                              child: (p.imageUrl == null || p.imageUrl!.isEmpty)
                                  ? Icon(Icons.person, size: 36, color: Colors.grey[400])
                                  : null,
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
                                  (p.rate?.toStringAsFixed(1) ?? '0.0'),
                                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // تفاصيل العامل
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
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
} 