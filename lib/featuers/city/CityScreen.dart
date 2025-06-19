import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  final List<String> _recentSearches = [
    'Playa Tijera',
    'Costa del Solana',
    'Sierra Blanca',
    'Sierra Vista',
    'Bahia Hermosa',
    'Valle Dorado',
    'Solstice Bay',
    'Pacifica Bluffs',
  ];

  List<String> getSuggestions(String query) {
    return _recentSearches
        .where((place) => place.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> _goToMyLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _mapController.move(LatLng(position.latitude, position.longitude), 14.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Bar with TypeAhead and Location Button
            Row(
              children: [
                Expanded(
                  child: TypeAheadField<String>(
                    suggestionsCallback: getSuggestions,
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _searchController.text = suggestion;
                      // يمكنك تحريك الخريطة هنا
                    },
                    noItemsFoundBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No places found.'),
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: _goToMyLocation,
                ),
              ],
            ),
            SizedBox(height: 12),
            // Map
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(33.4484, -112.0740), // Phoenix كمثال
                    initialZoom: 6.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
              ),
            ),
            // Recent Searches
            if (_searchController.text.isNotEmpty)
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ..._recentSearches.map((place) => ListTile(
                          title: Text(place),
                          onTap: () {
                            _searchController.text = place;
                            // يمكنك تحريك الخريطة هنا أيضاً
                          },
                        )),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}