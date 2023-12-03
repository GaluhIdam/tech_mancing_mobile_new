import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';
import 'package:tech_mancing/app/modules/Pemancingan/services/pemancingan.service.dart';

class PemancinganUserController extends GetxController {
  final PemancinganService pemancinganService = Get.put(PemancinganService());
  final AuthService authService = Get.put(AuthService());

  final LayoutController layoutController = Get.put(LayoutController());
  final TextEditingController searchController = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final List<DatumListPemancingan> listPemancingan =
      <DatumListPemancingan>[].obs;
  Rx<int> totalDataPemancingan = 0.obs;

  RxBool loading = false.obs;
  RxBool loadingMore = true.obs;
  String idUser = '';
  String latitude = '';
  String longitude = '';

  DateTime? currentBackPressTime;

  ScrollController scrollController = ScrollController();

  var page = 1;
  var paginate = 10;

  @override
  void onInit() {
    super.onInit();
    try {
      scrollController.addListener(() {
        loading.value = false;
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          page++;
          getDataPemancinganForUser(
                  searchController.text,
                  '$page',
                  paginate.toString(),
                  homeController.currentLocation.value!.latitude.toString(),
                  homeController.currentLocation.value!.longitude.toString())
              .then((value) => loading.value = true);
        }
      });
    } catch (e) {
      print('Error in PemancinganUserController onInit: $e');
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //Get Pemancingan By User
  Future<void> getDataPemancinganForUser(String search, String page,
      String paginate, String latitude, String longitude) async {
    try {
      await pemancinganService
          .getPemancinganForUser(search, page, paginate, latitude, longitude)
          .then((value) => {
                totalDataPemancingan.value = value.data.total,
                listPemancingan.addAll(value.data.data),
              });
    } catch (e) {
      print('Error fetching Pemancingan for user: $e');
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

  void getDataPemancinganFU() async {
    listPemancingan.clear();
    page = 1;
    await getDataPemancinganForUser(
            searchController.text,
            '$page',
            paginate.toString(),
            homeController.currentLocation.value!.latitude.toString(),
            homeController.currentLocation.value!.longitude.toString())
        .then((value) => loading.value = true);
  }

  //Distance Count
  int calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radiusEarth = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    // Haversine formula
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate distance in meters and round to the nearest whole number
    double distance = radiusEarth * c * 1000; // Convert to meters
    distance = distance.roundToDouble();

    return distance.toInt();
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  //Count Rating
  double calculateAverageRating(List<KomentarPemancingan> ratings) {
    if (ratings.isEmpty) {
      return 0.0; // Default to 0 if there are no ratings to avoid division by zero
    }
    List<int> result = [];
    ratings.forEach((element) {
      result.add(element.rate);
    });
    int sum = result.reduce((value, element) => value + element);
    double average = sum / ratings.length.toDouble();

    return average;
  }
}
