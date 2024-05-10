import 'dart:async';

import 'package:location/location.dart';
import 'package:mvvm_playground/functions/geolocation.dart';

class LocationService {
  LocationService() {
    Location location = Location();
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((dataLokasi) {
          _locationController
              .add(GeoLocation.createUserPointLocationData(dataLokasi));
        });
      }
    });
  }
  StreamController<GeoLocation> _locationController =
      StreamController<GeoLocation>();
  Stream<GeoLocation> get locationStream => _locationController.stream;

  Future<GeoLocation?> getLocation() async {
    Location location = Location();
    GeoLocation? _currentLocation;
    try {
      var userLocation = await location.getLocation();
      _currentLocation = GeoLocation.createUserPointLocationData(userLocation);
    } on Exception catch (e) {
      print('Gagal ambil lokasi: ${e.toString()}');
    }
    return _currentLocation;
  }
}
