import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/review_model/review_model.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(backgroundImage: AssetImage(review.image,), radius: 20),
                SizedBox(width: 8),
                Text(review.reviewerName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
                const Spacer(),
                Text(review.date, style: const TextStyle(color: AppColors.greyTextColor, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(
                review.rating,
                (index) => const Icon(Icons.star, size: 16, color:AppColors.primaryColor,)
              ),
            ),
            const SizedBox(height: 6),
            Text(review.comment, style: const TextStyle(color: AppColors.textColor)),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
