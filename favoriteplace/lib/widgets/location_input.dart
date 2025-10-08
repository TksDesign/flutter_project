import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  var _isGettingLocation = false;
  String? _address;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    try {
      locationData = await location.getLocation();
      final lat = locationData.latitude!;
      final lon = locationData.longitude!;

      final url = Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json");

      final response = await http.get(url, headers: {
        "User-Agent": "com.example.myapp (shanonntissie24@gmail.com)"
      }).timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);
      final address = data["display_name"];

      setState(() {
        _pickedLocation = locationData;
        _address = address;
        _isGettingLocation = false;
      });
    } on TimeoutException {
      print("⏱️ Timeout: la requête a pris trop de temps");
      setState(() => _isGettingLocation = false);
    } catch (error) {
      print("Erreur lors de getLocation(): $error");
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'No location choose',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    );
    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    } else if (_pickedLocation != null) {
      previewContent = SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            initialCenter:
                LatLng(_pickedLocation!.latitude!, _pickedLocation!.longitude!),
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.shanonn.favoriplace',
            ),
            MarkerLayer(markers: [
              Marker(
                  point: LatLng(
                      _pickedLocation!.latitude!, _pickedLocation!.longitude!),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ))
            ])
          ],
        ),
      );
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.3))),
            child: previewContent),
        if (_address != null) ...[
          const SizedBox(height: 8),
          Text(
            _address!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get the current location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Select Map'),
              icon: const Icon(Icons.map),
            )
          ],
        )
      ],
    );
  }
}
