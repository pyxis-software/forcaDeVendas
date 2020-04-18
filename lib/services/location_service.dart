import 'dart:async';

import 'package:forca_de_vendas/services/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;
  var location = Location();

  //
  StreamController<UserLocation> locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged().listen((locationData) {
          if (location != null) {
            locationController.add(
              UserLocation(locationData.latitude, locationData.longitude),
            );
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation =
          UserLocation(userLocation.latitude, userLocation.longitude);
    } catch (e) {
      print("Não foi possível pegar a localização!");
    }

    return _currentLocation;
  }
}
