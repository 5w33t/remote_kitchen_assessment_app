import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';
import 'package:remote_kitchen_assessment_app/app/modules/map/controllers/map_controller.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Google Map API',
      body: Obx(
        () {
          return controller.isMapLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: controller.currentLocation.value!,
                    zoom: 13,
                  ),
                  markers: controller.markers.toSet(),
                  onTap: (position) {
                    controller.setDestination(position);
                  },
                  polylines: Set<Polyline>.of(controller.polylines.values),
                  circles: {
                    Circle(
                        circleId: const CircleId('geofence_circle'),
                        center: controller.destinationLocation.value!,
                        radius: 200,
                        strokeColor: Colors.green,
                        fillColor: Colors.green.withOpacity(0.15),
                        strokeWidth: 2)
                  },
                );
        },
      ),
    );
  }
}
