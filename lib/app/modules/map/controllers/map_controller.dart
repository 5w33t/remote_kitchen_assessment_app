import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:remote_kitchen_assessment_app/app/modules/map/secrets/map_api_key.dart';

class MapController extends GetxController {
  final isMapLoading = RxBool(true);
  final currentLocation = Rxn<LatLng>();
  final destinationLocation = Rxn<LatLng>();
  final markers = RxList<Marker>([]);
  final polylines = <PolylineId, Polyline>{}.obs;
  final locationController = Location();
  final currentPosition = Rxn<LatLng>();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> initializeMap() async {
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  Future<void> fetchLocationUpdates(Location locationController) async {
    bool serviceEnabled;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentPosition.value = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
      }
    });

    locationController.onLocationChanged.listen((newLoc) {
      var distanceBetween = haversineDistance(
          LatLng(newLoc.latitude!, newLoc.longitude!),
          destinationLocation.value!);

      if (distanceBetween < 200) {
        Get.snackbar(
          'ARRIVED!',
          'You have reached your destination',
          backgroundColor: Colors.blueGrey.shade700,
          colorText: Colors.blueGrey.shade100,
          icon: const Icon(Icons.location_on),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  void setDestination(LatLng position) async {
    if (markers.length > 2) {
      markers.removeLast();
    }
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        icon: BitmapDescriptor.defaultMarker,
        position: position,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );

    destinationLocation.value = position;
    await initializeMap(); // 37.4219983, -122.084
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    if (currentLocation.value != null && destinationLocation.value != null) {
      final result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapAPIKey,
        PointLatLng(
            currentLocation.value!.latitude, currentLocation.value!.longitude),
        PointLatLng(destinationLocation.value!.latitude,
            destinationLocation.value!.longitude),
      );

      if (result.points.isNotEmpty) {
        return result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      } else {
        debugPrint(result.errorMessage);
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    polylines[id] = polyline;
  }

  dynamic haversineDistance(LatLng source, LatLng destination) {
    double lat1 = source.latitude;
    double lon1 = source.longitude;
    double lat2 = destination.latitude;
    double lon2 = destination.longitude;

    var R = 6371e3; // metres
    // var R = 1000;
    var phi1 = (lat1 * pi) / 180; // φ, λ in radians
    var phi2 = (lat2 * pi) / 180;
    var deltaPhi = ((lat2 - lat1) * pi) / 180;
    var deltaLambda = ((lon2 - lon1) * pi) / 180;

    var a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var d = R * c; // in metres
    return d;
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
    LocationData locationData = await location.getLocation();
    LatLng position = LatLng(locationData.latitude!, locationData.longitude!);
    currentLocation.value = position;

    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Current Location'),
        position: currentLocation.value!,
      ),
    );
    // setting default geofence near current location
    setDestination(
        LatLng(position.latitude - 0.033, position.longitude - 0.003));
    Get.snackbar(
      'Tap on map to add geofence',
      'Tap anywhere in the map to create a geofence',
      backgroundColor: Colors.blueGrey.shade700,
      colorText: Colors.blueGrey.shade100,
      icon: const Icon(Icons.location_on),
    );

    fetchLocationUpdates(location);

    isMapLoading.value = false;
  }
}
