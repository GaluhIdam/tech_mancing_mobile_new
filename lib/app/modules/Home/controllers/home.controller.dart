import 'dart:async';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class HomeController extends GetxController {
  // Observables
  Rx<Position?> currentLocation = Rx<Position?>(null);
  RxDouble compassHeading = 0.0.obs;
  RxDouble gpsHeading = 0.0.obs;
  bool hasPermissions = false;
  CompassEvent? lastRead;

  RxBool startRoute = false.obs;
  DateTime? currentBackPressTime;

  // MapController
  final MapController mapController = MapController();

  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void onInit() async {
    super.onInit();
    startRoute.value = false;
    await getPosition();
    await getCompass();
    await getStreamPosition();
  }

  @override
  void dispose() {
    mapController.dispose();
    startRoute.value = false;
    _positionStreamSubscription?.cancel();
    _compassSubscription?.cancel();
    super.dispose();
  }

  Future<void> getPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = position;
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getStreamPosition() async {
    try {
      final positionStream = Geolocator.getPositionStream(
          locationSettings:
              AndroidSettings(accuracy: LocationAccuracy.bestForNavigation));
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => currentLocation.value = position);
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getCompass() async {
    try {
      final compassStream = FlutterCompass.events;
      _compassSubscription = compassStream?.handleError((error) {
        _compassSubscription?.cancel();
        _compassSubscription = null;
      }).listen((event) {
        compassHeading.value = event.heading ?? 0.0;
        if (startRoute == true) {
          currentMyLocation();
        }
      });
      update();
    } catch (e) {
      rethrow;
    }
  }

  void currentMyLocation() {
    if (currentLocation.value != null) {
      mapController.moveAndRotate(
        LatLng(
            currentLocation.value!.latitude, currentLocation.value!.longitude),
        17,
        compassHeading.value * -1,
      );
    }
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Back again to exit");
      return false;
    }
    Get.back();
    return true;
  }
}
