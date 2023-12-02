import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';
import 'package:tech_mancing/app/modules/Pemancingan/services/pemancingan.service.dart';

class HomeController extends GetxController {
  final PemancinganService pemancinganService = Get.put(PemancinganService());
  final AuthService authService = Get.put(AuthService());

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  Rx<Position?> currentLocation = Rx<Position?>(null);
  RxDouble compassHeading = 0.0.obs;
  RxDouble gpsHeading = 0.0.obs;
  bool hasPermissions = false;
  CompassEvent? lastRead;

  RxBool startRoute = false.obs;
  RxBool loading = false.obs;
  DateTime? currentBackPressTime;

  // MapController
  final MapController mapController = MapController();

  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  final List<DatumListPemancingan> listPemancingan =
      <DatumListPemancingan>[].obs;
  Rx<int> totalDataPemancingan = 0.obs;

  final RxString searchQuery = ''.obs;
  final List<DatumListPemancingan> listPemancinganSearch =
      <DatumListPemancingan>[].obs;
  Rx<int> totalDataPemancinganSearch = 0.obs;

  var page = 1;
  var paginate = 10;

  @override
  void onInit() {
    super.onInit();
    startRoute.value = false;
    getPosition();
    getCompass();
    getStreamPosition();
  }

  @override
  void dispose() {
    mapController.dispose();
    startRoute.value = false;
    _cancelSubscriptions();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _positionStreamSubscription?.cancel();
    _compassSubscription?.cancel();
  }

  Future<void> getPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      currentLocation.value = position;
      update();
    } catch (e) {
      print('Error getting position: $e');
    }
  }

  Future<void> getStreamPosition() async {
    try {
      final positionStream = Geolocator.getPositionStream(
        locationSettings:
            AndroidSettings(accuracy: LocationAccuracy.bestForNavigation),
      );
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) {
        currentLocation.value = position;
        getDataPemancinganForUser(
            '',
            '$page',
            paginate.toString(),
            currentLocation.value!.latitude.toString(),
            currentLocation.value!.longitude.toString());
      });
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
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Back again to exit');
      return false;
    }
    Get.back();
    return true;
  }

  // Get Pemancingan By User
  Future<void> getDataPemancinganForUser(String search, String page,
      String paginate, String latitude, String longitude) async {
    try {
      final value = await pemancinganService.getPemancinganForUser(
          search, page, paginate, latitude, longitude);
      totalDataPemancingan.value = value.data.total;
      listPemancingan.addAll(value.data.data);
    } catch (e) {
      print('Error fetching Pemancingan: $e');
    }
  }

  // Search
  Future<void> getDataPemancinganForUserSearch(String search, String page,
      String paginate, String latitude, String longitude) async {
    try {
      final value = await pemancinganService.getPemancinganForUser(
          search, page, paginate, latitude, longitude);
      totalDataPemancinganSearch.value = value.data.total;
      listPemancinganSearch.addAll(value.data.data);
      loading.value = false;
    } catch (e) {
      print('Error fetching Pemancingan: $e');
    }
  }

  void onSearchQueryChanged(String query) {
    getDataPemancinganForUserSearch(
        query,
        '$page',
        paginate.toString(),
        currentLocation.value!.latitude.toString(),
        currentLocation.value!.longitude.toString());
  }
}
