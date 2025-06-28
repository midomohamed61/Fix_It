import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<String> availableJobs;
  final String? selectedJob;

  const FilterScreen({super.key, required this.availableJobs, this.selectedJob});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Service Type
  List<String> serviceTypes = [
    'ALL', 'wiring', 'repairs', 'emergency', 'installations'
  ];
  String selectedServiceType = 'ALL';

  // Availability
  String selectedAvailability = 'specific times';

  // Rating
  double minRating = 0;
  double maxRating = 5;
  RangeValues ratingRange = const RangeValues(0, 5);

  // Pricing
  double minPrice = 10;
  double maxPrice = 500;
  RangeValues priceRange = const RangeValues(10, 500);

  // Experience Level
  List<String> experienceLevels = [
    'ALL', 'A year', '2 year', '3 year', '4 year', '5+ year', '10+ year'
  ];
  String selectedExperience = 'ALL';

  // Specializations
  List<String> specializations = [
    'Residential', 'Commercial', 'HVAC', 'Lighting', 'Smart home installations'
  ];
  Set<String> selectedSpecializations = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Filter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Type
            const Text('Service Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: serviceTypes.map((type) => ChoiceChip(
                label: Text(type),
                selected: selectedServiceType == type,
                onSelected: (_) => setState(() => selectedServiceType = type),
              )).toList(),
            ),
            const SizedBox(height: 20),
            // Availability
            const Text('Availability', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    value: 'Electrician Urgently',
                    groupValue: selectedAvailability,
                    onChanged: (val) => setState(() => selectedAvailability = val!),
                    title: const Text('Electrician Urgently', style: TextStyle(fontSize: 14)),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: 'specific times',
                    groupValue: selectedAvailability,
                    onChanged: (val) => setState(() => selectedAvailability = val!),
                    title: const Text('specific times', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Rating
            const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${ratingRange.start.toStringAsFixed(1)}★'),
                Text('${ratingRange.end.toStringAsFixed(1)}★'),
              ],
            ),
            RangeSlider(
              min: minRating,
              max: maxRating,
              values: ratingRange,
              divisions: 10,
              onChanged: (values) => setState(() => ratingRange = values),
            ),
            const SizedBox(height: 20),
            // Pricing
            const Text('Pricing', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${priceRange.start.toInt()}'),
                Text('${priceRange.end.toInt()}'),
              ],
            ),
            RangeSlider(
              min: minPrice,
              max: maxPrice,
              values: priceRange,
              divisions: 49,
              onChanged: (values) => setState(() => priceRange = values),
            ),
            const SizedBox(height: 20),
            // Experience Level
            const Text('Experience Level', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: experienceLevels.map((level) => ChoiceChip(
                label: Text(level),
                selected: selectedExperience == level,
                onSelected: (_) => setState(() => selectedExperience = level),
              )).toList(),
            ),
            const SizedBox(height: 20),
            // Specializations
            const Text('Specializations', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: specializations.map((spec) => FilterChip(
                label: Text(spec),
                selected: selectedSpecializations.contains(spec),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedSpecializations.add(spec);
                    } else {
                      selectedSpecializations.remove(spec);
                    }
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1566C2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // Return all selected filter values as a map
                  Navigator.pop(context, {
                    'serviceType': selectedServiceType,
                    'availability': selectedAvailability,
                    'ratingRange': ratingRange,
                    'priceRange': priceRange,
                    'experience': selectedExperience,
                    'specializations': selectedSpecializations.toList(),
                  });
                },
                child: const Text('Apply Filter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 