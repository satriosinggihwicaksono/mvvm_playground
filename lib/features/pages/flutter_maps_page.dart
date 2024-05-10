import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:mvvm_playground/const/theme.dart';
import 'package:mvvm_playground/functions/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

// add-- permisions
class FlutterMapPage extends StatefulWidget {
  const FlutterMapPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeViewPageState();
  }
}

class _HomeViewPageState extends State<FlutterMapPage> {
  late MapController mapController = MapController();
  late Stream<latLng.LatLng> locationStream;

  Polyline firstPolyline = Polyline(
    points: [
      latLng.LatLng(-6.2279168, 106.8333919),
      latLng.LatLng(-6.2279168, 106.8333919),
      latLng.LatLng(-6.2280967, 106.833408),
      latLng.LatLng(-6.2280823, 106.8334129),
      latLng.LatLng(-6.2283086, 106.8334488),
      latLng.LatLng(-6.2284237, 106.8334237),
      latLng.LatLng(-6.228418, 106.833809),
    ],
    color: Colors.green,
    strokeWidth: 2.0,
    isDotted: false,
    useStrokeWidthInMeter: true,
  );

  List<dynamic> tree = [
    {"lat": -6.2277937, "long": 106.8327623, "tree": 'Palma One'},
    {"lat": -6.228418, "long": 106.833359, "tree": 'Tikungan Pom Bensin'},
    {"lat": -6.228384, "long": 106.834523, "tree": 'Belokan Nasi Soto'},
    {"lat": -6.2283196, "long": 106.8336922, "tree": 'Kebab Turki'},
  ];

  @override
  void initState() {
    super.initState();
    locationStream = getLocationStream();
  }

  Stream<latLng.LatLng> getLocationStream() async* {
    while (true) {
      await Permission.location.request();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      yield latLng.LatLng(position.latitude, position.longitude);
      await Future.delayed(Duration(seconds: 1));
    }
  }

  double metersToPixels(double meters, double latitude, double zoom) {
    final metersPerPixel =
        (156543.03392 * math.cos(latitude * math.pi / 180) / math.pow(2, zoom));
    return meters / metersPerPixel;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildInputDataBody(context),
    );
  }

  Widget _buildInputDataBody(BuildContext context) {
    return StreamBuilder<latLng.LatLng>(
      stream: locationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userLocation = Provider.of<GeoLocation>(context);
          userLocation.radiuscentermeters = 10;
          for (var i = 0; i < tree.length; i++) {
            userLocation.setPointCenter(
                tree[i]['lat'] ?? 0.0, tree[i]['long'] ?? 0.0);
          }
          var userLocationCurrent = snapshot.data!;
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      initialZoom: 15,
                      initialCenter: latLng.LatLng(userLocationCurrent.latitude,
                          userLocationCurrent.longitude)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    PolylineLayer(
                      polylines: [firstPolyline],
                      polylineCulling: true,
                    ),
                    CircleLayer(
                      circles: [
                        CircleMarker(
                            point: latLng.LatLng(userLocationCurrent.latitude,
                                userLocationCurrent.longitude),
                            color: Colors.blue.withOpacity(0.3),
                            radius: metersToPixels(
                                10, userLocationCurrent.latitude, 15.0)),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            width: 300.0,
                            height: 300.0,
                            point: latLng.LatLng(userLocationCurrent.latitude,
                                userLocationCurrent.longitude),
                            child: Icon(
                              Icons.supervised_user_circle,
                              color: Colors.green,
                            )),
                        for (var i = 0; i < tree.length; i++)
                          Marker(
                            width: 300.0,
                            height: 300.0,
                            point: latLng.LatLng(
                                tree[i]['lat'] ?? 0.0, tree[i]['long'] ?? 0.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    size: 48,
                                    Icons.pin_drop,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: primaryColor),
                                  child: Text(
                                    tree[i]['tree'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text('Latitude : ${userLocationCurrent.latitude}'),
                    Text('Longitude : ${userLocationCurrent.longitude}'),
                    Text(
                        'Posisi dekat Pohon?: ${userLocation.status.contains(true)}'),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator(); // Loading indicator while waiting for data
        }
      },
    );
  }
}
