import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  List<String> availableTimes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final savedDate = await SharedPrefHelper.getString('selected_date');
    final savedTime = await SharedPrefHelper.getString('selected_time');
    final savedTimesList = await SharedPrefHelper.getStringList('available_times');

    setState(() {
      if (savedDate.isNotEmpty) _selectedDate = DateTime.tryParse(savedDate);
      if (savedTime.isNotEmpty) _selectedTime = savedTime;
      availableTimes = savedTimesList.isNotEmpty
          ? savedTimesList
          : [
              '09:00', '10:00', '11:00', '12:00',
              '01:00', '02:00', '03:00', '04:00',
              '05:00', '06:00', '07:00', '08:00',
            ];
    });
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
    SharedPrefHelper.setData<String>('selected_time', time);
  }

  void _handleNext() {
    if (_selectedDate != null && _selectedTime != null) {
      SharedPrefHelper.setData<String>('selected_date', _selectedDate!.toIso8601String());
      SharedPrefHelper.setData<String>('selected_time', _selectedTime!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Date and time saved successfully')),
      );
      Navigator.pushReplacementNamed(context, '/ReviewSummaryScreen');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date and time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final amTimes = availableTimes.where((t) => t.compareTo('12:00') <= 0).toList();
    final pmTimes = availableTimes.where((t) => t.compareTo('12:00') > 0).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Plumber booking',
          style: TextStyle(color: AppColors.textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - kToolbarHeight - 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    selectedDayHighlightColor: AppColors.primaryColor,
                    weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                    weekdayLabelTextStyle: TextStyle(color: AppColors.textColor),
                    dayTextStyle: TextStyle(color: AppColors.textColor),
                    selectedDayTextStyle: TextStyle(color: Colors.white),
                    disabledDayTextStyle: TextStyle(color: AppColors.greyTextColor),
                    firstDate: DateTime(2023, 1, 1),
                    lastDate: DateTime(2035, 12, 31),
                    currentDate: DateTime.now(),
                    controlsHeight: 50,
                  ),
                  value: _selectedDate != null ? [_selectedDate!] : [],
                  onValueChanged: (dates) {
                    if (dates.isNotEmpty) {
                      setState(() {
                        _selectedDate = dates[0];
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Select Hours',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              _buildTimeSection('AM', amTimes),
              SizedBox(height: 16),
              _buildTimeSection('PM', pmTimes),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSection(String label, List<String> times) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: AppColors.textColor)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: times.map((time) {
            return _buildTimeButton(time, isSelected: _selectedTime == time);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeButton(String time, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => _selectTime(time),
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
