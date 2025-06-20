import 'package:fix_it/core/themes/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  _LocationPermissionScreenState createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  // طلب إذن الموقع
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  // التعامل مع اختيار المستخدم
  void _handlePermissionSelection(String choice) {
    switch (choice) {
      case 'ALLOW ONCE':
        _requestLocationPermission().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location allowed once')),
          );
        });
        break;
      case 'ALLOW WHILE USING FIXIT':
        _requestLocationPermission().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location allowed while using app')),
          );
        });
        break;
      case 'DON\'T ALLOW':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location access denied')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.popAndPushNamed(context, '/ProviderProfileScreen'),
        ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Allow "Fixit" to use your location.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We need to know your exact location so that the electrician can visit you easily.',
              style: TextStyle(fontSize: 14, color: AppColors.greyTextColor),
            ),
            SizedBox(height: 16),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(30.0444, 31.2357),
                  maxZoom: 13.0,
                  interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // أزرار السماح
            _buildPermissionButton('ALLOW ONCE'),
            _buildPermissionButton('ALLOW WHILE USING FIXIT'),
            _buildPermissionButton('DON\'T ALLOW'),

            Spacer(),

            // زر Fill Manually
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fill manually selected')),
                  );
                  Navigator.pushReplacementNamed(context, '/LocationAddressScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'FILL MANUALLY',
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
    );
  }

  // دالة لإنشاء أزرار السماح
  Widget _buildPermissionButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _handlePermissionSelection(title),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}