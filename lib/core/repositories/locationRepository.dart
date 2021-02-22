import 'package:location/location.dart';

class LocationRepository {
  LocationRepository();

  static final LocationRepository _instance = LocationRepository();
  static LocationRepository get instance => _instance;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<Map<String, String>> getCurrentCoordinates() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return {"error": "La ubicación no está activada."};
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return {"error": "No hay permisos para obtener la ubicación."};
      }
    }
    try {
      _locationData = await location.getLocation();
      print("_locationData: ${_locationData.toString()}");
      return {
        "lat": _locationData.latitude.toString(),
        "lon": _locationData.longitude.toString()
      };
    } catch (e) {
      print("Error: $e");
      return {"error": "Hubo un error al obtener la ubicación actual."};
    }
  }
}
