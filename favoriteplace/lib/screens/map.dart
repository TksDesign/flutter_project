import 'package:favoriteplace/model/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          adress: '',
          latitude: 3.9276907590379797,
          longitude: 11.521996619016173),
      this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ))
        ],
      ),
      body: FlutterMap(
          options: MapOptions(
              initialCenter:
                  LatLng(widget.location.latitude, widget.location.longitude),
              initialZoom: 10,
              onTap: (tapPosition, point) {
                setState(() {
                  _pickedLocation = point;
                });
              }),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.shanonn.favoriplace',
            ),
            MarkerLayer(
                markers: (_pickedLocation == null && widget.isSelecting)
                    ? []
                    : [
                        Marker(
                            point: _pickedLocation ??
                                LatLng(widget.location!.latitude!,
                                    widget.location!.longitude!),
                            width: 60,
                            height: 60,
                            child: const Icon(
                              Icons.location_pin,
                              color: Color.fromARGB(255, 3, 15, 90),
                              size: 40,
                            ))
                      ])
          ]),
    );
  }
}
