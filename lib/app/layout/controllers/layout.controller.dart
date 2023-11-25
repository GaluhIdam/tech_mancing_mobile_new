import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/routes/routes.dart';

class LayoutController extends GetxController {
  final AuthService authService = Get.put(AuthService());

  String? name;
  String? email;

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    explorasiPage();
  }

  RxString currentRoute = "Explorasi".obs;
  RxString title = "Explorasi".obs;
  Rx<Icon?> myIcon = Rx<Icon?>(null);

  void explorasiPage() {
    currentRoute.value = AppRoutes.home;
    title.value = "Explorasi";
    myIcon.value = const Icon(Icons.map);
    Get.back();
  }

  void acaraSayaPage() {
    currentRoute.value = AppRoutes.acara;
    title.value = "Acara Saya";
    myIcon.value = const Icon(Icons.event);
    Get.back();
  }

  void daftarAcaraSayaPage() {
    currentRoute.value = AppRoutes.daftarAcara;
    title.value = "Acara Saya";
    myIcon.value = const Icon(Icons.event);
    Get.back();
  }

  void detailAcaraPage() {
    currentRoute.value = AppRoutes.detailAcara;
    title.value = "Detail Acara";
    myIcon.value = const Icon(Icons.event);
    Get.back();
  }

  void pemancinganPage() {
    currentRoute.value = AppRoutes.pemancingan;
    title.value = "Pemancingan";
    myIcon.value = const Icon(Icons.phishing);
    Get.back();
  }

  void pemancinganSayaPage() {
    currentRoute.value = AppRoutes.pemancinganSaya;
    title.value = "Pemancingan Saya";
    myIcon.value = const Icon(Icons.phishing);
    Get.back();
  }

  void daftarPemancinganPage() {
    currentRoute.value = AppRoutes.daftarPemancingan;
    title.value = "Daftar Pemancingan";
    myIcon.value = const Icon(Icons.phishing);
    Get.back();
  }

  void detailPemancinganPage() {
    currentRoute.value = AppRoutes.detailPemancingan;
    title.value = "Detail Pemancingan";
    myIcon.value = const Icon(Icons.phishing);
    Get.back();
  }

  Future<void> getUserDetail() async {
    try {
      await this.authService.getUserDetail().then((value) {
        name = value.data.name;
        email = value.data.email;
      });
    } catch (e) {
      print(e);
    }
  }
}
