import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 0;
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('last_rating', _rating);
    await prefs.setString('last_feedback', _controller.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give your feedback', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How was your experience with Fix it?', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    _rating >= index + 1
                        ? Icons.star
                        : _rating >= index + 0.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: AppColors.primaryColor,
                    size: 36,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      _rating = index + 0.5;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text('Write in bellow box'),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write here...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.backgroundColor,
                ),
                onPressed: _saveFeedback,
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 