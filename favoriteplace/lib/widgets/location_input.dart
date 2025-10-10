import 'dart:async';
import 'dart:convert';

import 'package:favoriteplace/model/place.dart';
import 'package:favoriteplace/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  String? _address;

  // String get locationImage {
  //   final lat = _pickedLocation!.latitude;
  //   final lon = _pickedLocation!.longitude;

  //   return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lon&key=AIzaSyDlcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
  // }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json");

    final response = await http.get(url, headers: {
      "User-Agent": "com.example.myapp (shanonntissie24@gmail.com)"
    });

    final data = jsonDecode(response.body);
    final address = data["display_name"];

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, adress: address);
      _address = address;
      _isGettingLocation = false;
      print(longitude);
      print(latitude);
    });
    // tranmissionn de donne
    widget.onSelectLocation(_pickedLocation!);
  }

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

    // try {
    //   locationData = await location.getLocation();
    //   final lat = locationData.latitude!;
    //   final lon = locationData.longitude!;
    //   if (lat == null || lon == null) {
    //     return;
    //   }
    //   final url = Uri.parse(
    //       'https://maps.googleapis.com/maps/api/geocode/json?$lat,$lon&key=AIzaSyDlcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag');
    //   final reponse = await http.get(url);
    //   final resData = jsonDecode(reponse.body);
    //   final adress = resData['results'][0]["formatted_address"];

    //   setState(() {
    //     _pickedLocation =
    //         PlaceLocation(latitude: lat, longitude: lon, adress: adress);
    //     _isGettingLocation = false;
    //   });
    // } catch (e) {
    //   print("Erreur lors de getLocation(): $e");
    //   _isGettingLocation = false;
    // }
    try {
      locationData = await location.getLocation();
      final lat = locationData.latitude!;
      final lon = locationData.longitude!;

      if (lat == null || lon == null) {
        return;
      }
      _savePlace(lat, lon);
    } catch (error) {
      print("Erreur lors de getLocation(): $error");
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  // selection de l'emplacement

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen()));
    if (pickedLocation == null) {
      return;
    }
    setState(() {
      _savePlace(pickedLocation.latitude, pickedLocation.longitude);
    });
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
      // previewContent = Image.network(locationImage,
      //     fit: BoxFit.cover, width: double.infinity, height: double.infinity);
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
              onPressed: _selectOnMap,
              label: const Text('Select Map'),
              icon: const Icon(Icons.map),
            )
          ],
        )
      ],
    );
  }
}
