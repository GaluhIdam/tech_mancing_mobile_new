import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-user.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/detail-pemancingan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/services/pemancingan.service.dart';

class PemancinganDetailController extends GetxController {
  final PemancinganService pemancinganService = Get.put(PemancinganService());
  final AuthService authService = Get.put(AuthService());
  final LayoutController layoutController = Get.put(LayoutController());
  final PemancinganUserController pemancinganUserController =
      Get.put(PemancinganUserController());
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController komentar = TextEditingController();

  Rx<int> idUserCheck = 0.obs;
  Rx<int> idPemancingan = 0.obs;
  Rx<int> idUser = 0.obs;
  Rx<int> rate = 0.obs;
  Rx<String> urlImage = ''.obs;
  Rx<String> namaController = ''.obs;
  Rx<String> descriptionController = ''.obs;
  Rx<String> alamatController = ''.obs;
  Rx<String> bukaController = ''.obs;
  Rx<String> tutupController = ''.obs;
  Rx<String> selectedKategori = ''.obs;
  Rx<String> selectedProvinsi = ''.obs;
  Rx<String> selectedKota = ''.obs;
  Rx<String> selectedKecamatan = ''.obs;
  List<KomentarPemancingan> komentarPemancingan = [];

  DateTime? currentBackPressTime;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDetailUser();
  }

  Future<void> getPemancinganById(int id) async {
    try {
      komentarPemancingan.clear();
      await pemancinganService.getDetailPemancingan(id).then((value) async {
        urlImage.value =
            'http://192.168.163.118:8000/api/images-pemancingan/${value.data.image}';
        idPemancingan.value = value.data.id;
        idUser.value = value.data.userPemancingan.id;
        namaController.value = value.data.namaPemancingan;
        descriptionController.value = value.data.deskripsi;
        alamatController.value = value.data.alamat;
        bukaController.value = value.data.buka;
        tutupController.value = value.data.tutup;
        selectedKategori.value = value.data.category;
        selectedProvinsi.value = value.data.provinsi;
        selectedKota.value = value.data.kota;
        selectedKecamatan.value = value.data.kecamatan;
        komentarPemancingan.addAll(value.data.komentarPemancingan);
        layoutController.detailUserPemancinganPage();
      });
    } catch (e) {
      print('Error getting Pemancingan: $e');
    }
  }

  Future<bool> backToPemancingan() async {
    getDetailUser();
    layoutController.pemancinganPage();
    pemancinganUserController.getDataPemancinganFU();
    return false;
  }

  Row buildStarRating(int rating) {
    const int maxRating = 5;
    List<Widget> stars = List.generate(
      maxRating,
      (index) => Icon(
        index < rating ? Icons.star : Icons.star_border,
        size: 15.0,
        color: index < rating ? Colors.amber : Colors.grey,
      ),
    );

    return Row(children: stars);
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

  Future<void> getDetailUser() async {
    try {
      loading.value = false;
      await authService.getUserDetail().then((value) {
        idUserCheck.value = value.data.id;
      });
    } catch (e) {
      print('Error fetching detail user data: $e');
    }
  }

  Future<void> postKomentar(context) async {
    try {
      if (komentar.text.isNotEmpty && rate.value > 0) {
        await pemancinganService
            .createKomentar(idPemancingan.value, idUserCheck.value,
                komentar.text, rate.value)
            .then((value) async {
          if (value == true) {
            loading.value = true;
            komentarPemancingan.clear();
            komentar.text = '';
            rate.value = 0;
            await pemancinganService
                .getDetailPemancingan(idPemancingan.value)
                .then((valuex) {
              komentarPemancingan.addAll(valuex.data.komentarPemancingan);
              loading.value = false;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text('Komentar Terkirim!')));
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text('Server Internal Error!')));
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Ketikan komentar dan Rate anda terlebih dahulu!')));
      }
    } catch (e) {
      print('Error creating Pemancingan: $e');
    }
  }
}
