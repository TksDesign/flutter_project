import 'package:favoriteplace/model/place.dart';
import 'package:favoriteplace/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;
  String getOSMLocationImageUrl(double lat, double lon) {
    return 'https://staticmap.openstreetmap.de/staticmap.php?center=$lat,$lon&zoom=15&size=200x200&markers=$lat,$lon,red-pushpin';
  }

  @override
  Widget build(BuildContext context) {
    Widget circA = ClipOval(
        child: GestureDetector(
      onTap: () {
        print('taper');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MapScreen(
                  location: place.location,
                  isSelecting: false,
                )));
      },
      child: Container(
        color: Colors.transparent,
        width: 120,
        height: 120,
        child: IgnorePointer(
          child: FlutterMap(
              options: MapOptions(
                  initialCenter:
                      LatLng(place.location.latitude, place.location.longitude),
                  initialZoom: 15,
                  interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none //pour ne pas acoir de zoom
                      )),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.shanonn.favoriplace',
                ),
                MarkerLayer(markers: [
                  Marker(
                      point: LatLng(place.location!.latitude!,
                          place.location!.longitude!),
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 8, 6, 97),
                        size: 40,
                      ))
                ])
              ]),
        ),
      ),
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text(
            place.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Image.file(
              place.file,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    circA,
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 26),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Text(
                        place.location.adress,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
