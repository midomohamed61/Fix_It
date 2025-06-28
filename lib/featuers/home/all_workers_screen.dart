import 'package:flutter/material.dart';
import 'package:fix_it/core/models/worker/worker_response.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/workers_cubit.dart';

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({super.key});

  Color getWorkerCardColor(int i) {
    final bgColors = [Color(0xFFE3F0FF), Color(0xFFFFE3F0), Color(0xFFF0FFE3), Color(0xFFFFF7E3)];
    return bgColors[i % bgColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Service Providers", style: TextStyle(color: AppColors.primaryColor)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<WorkersCubit, WorkersState>(
          builder: (context, state) {
            if (state is WorkersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WorkersError) {
              return Center(child: Text(state.message));
            }
            if (state is WorkersLoaded) {
              final workers = state.workers;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: workers.length,
                itemBuilder: (context, i) {
                  final p = workers[i];
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
} 