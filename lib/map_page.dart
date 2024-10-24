import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // For getting current location
import 'dart:math'; // For generating random bike locations

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(12.9716, 77.5946);

  // List of markers
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get user's current location
  }

  void _getCurrentLocation() async {
    // Request location permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings(); // Request to enable location
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return; // Permissions are denied forever, handle appropriately
      }
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Update map with user's location and add bike locations
    setState(() {
      LatLng currentLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: currentLocation,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // Move the camera to the current location
      mapController.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 14));

      // Add multiple bike locations within 5km
      _addBikeLocations(currentLocation);
    });
  }

  // Method to generate random bike locations within 5 km
  void _addBikeLocations(LatLng currentLocation) {
    final random = Random();
    const double radius = 2000; // 2 km

    for (int i = 0; i < 5; i++) {
      double angle = random.nextDouble() * 2 * pi;
      double distance = random.nextDouble() * radius;
      double deltaLat = distance * cos(angle) / 111320; // Approx for latitude
      double deltaLng = distance * sin(angle) / (111320 * cos(currentLocation.latitude * pi / 180));

      LatLng bikeLocation = LatLng(
        currentLocation.latitude + deltaLat,
        currentLocation.longitude + deltaLng,
      );

      // Add bike marker
      _markers.add(
        Marker(
          markerId: MarkerId('bike$i'),
          position: bikeLocation,
          infoWindow: InfoWindow(title: 'Bike $i'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 10.0,
      ),
      markers: _markers, // Display the markers
      myLocationEnabled: true, // Enable showing the user's current location
      myLocationButtonEnabled: true, // Enable the location button
      mapType: MapType.normal,
    );
  }
}
