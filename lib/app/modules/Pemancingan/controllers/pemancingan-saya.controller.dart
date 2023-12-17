import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kecamatan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kota.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/pemancingan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/provinsi.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/services/pemancingan.service.dart';

class PemancinganSayaContoller extends GetxController {
  final PemancinganService pemancinganService = Get.put(PemancinganService());
  final AuthService authService = Get.put(AuthService());
  final LayoutController layoutController = Get.put(LayoutController());

  final GlobalKey<FormState> formDaftar = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController bukaController = TextEditingController();
  final TextEditingController tutupController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController pesanController = TextEditingController();

  DateTime? currentBackPressTime;

  RxString searchPemancinganSaya = ''.obs;

  ScrollController scrollController = ScrollController();

  Rx<LatLng> markerLocation = const LatLng(0, 0).obs;

  RxBool descController = false.obs;

  final List<DatumListPemancingan> listPemancinganByUser =
      <DatumListPemancingan>[].obs;

  Rx<int> totalDataPemancinganByUser = 0.obs;

  // Kategori
  final List<String> kategori = ['Keluarga', 'Harian'].obs;
  final Rx<String> selectedKategori = ''.obs;

  // Provinsi
  final List<ProvinsiDto> provinsi = <ProvinsiDto>[].obs;
  final Rx<ProvinsiDto> selectedProvinsi = ProvinsiDto(id: '', name: '').obs;

  //Kota
  final List<KotaDto> kota = <KotaDto>[].obs;
  final Rx<KotaDto> selectedKota =
      KotaDto(id: '', name: '', provinceId: '').obs;

  //Kecamatan
  final List<KecamatanDto> kecamatan = <KecamatanDto>[].obs;
  final Rx<KecamatanDto> selectedKecamatan = KecamatanDto(
    id: '',
    name: '',
    regencyId: '',
  ).obs;

  RxString statusPemancingan = ''.obs;

  RxBool statusDesc = false.obs;

  String idUser = '';
  String isAdmin = 'false';

  RxBool loading = false.obs;
  RxBool loadingMore = true.obs;

  //Image
  Rx<String> filePath = ''.obs;
  Rx<File>? selectedImage;

  String idPemancingan = '';
  Rx<bool> changeFile = false.obs;

  Rx<String> urlImage = ''.obs;

  var page = 1;
  var paginate = 10;

  @override
  void onInit() {
    super.onInit();
    getDetailUser()
        .then((value) => getDataPemancinganByUser(
            searchController.text, '$page', idUser, paginate.toString()))
        .then((value) => loading.value = true);
    getProvinsiData();
    resetDropdown();
    scrollController.addListener(() {
      loading.value = false;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getDetailUser()
            .then((value) => getDataPemancinganByUser(
                searchController.text, '$page', idUser, paginate.toString()))
            .then((value) => loading.value = true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getDetailUser() async {
    try {
      loading.value = false;
      await authService.getUserDetail().then((value) {
        idUser = value.data.id.toString();
      });
    } catch (e) {
      print('Error fetching detail user data: $e');
    }
  }

  Future<void> pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);
        if (file.lengthSync() > 1 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text("Maximum File 1 MB!")));
          changeFile.value = false;
          filePath.value = '';
        } else {
          changeFile.value = true;
          filePath.value = file.path;
        }
      } else {
        changeFile.value = false;
        filePath.value = '';
      }
    } catch (e) {
      print('Error fetching file data: $e');
    }
  }

  // Get Provinsi
  Future<void> getProvinsiData() async {
    try {
      provinsi.assignAll(await pemancinganService.getProvinsi());
    } catch (e) {
      print('Error fetching provinsi data: $e');
    }
  }

  //Get Kota
  Future<void> getKotaData(String id) async {
    try {
      kota.assignAll(await pemancinganService.getKota(id));
    } catch (e) {
      print('Error fetching provinsi data: $e');
    }
  }

  //Get Kecamatan
  Future<void> getKecamatanData(String id) async {
    try {
      kecamatan.assignAll(await pemancinganService.getKecamatan(id));
    } catch (e) {
      print('Error fetching provinsi data: $e');
    }
  }

  // Reset Data
  void resetDropdown() {
    page = 1;
    markerLocation = const LatLng(0, 0).obs;
    filePath.value = '';
    selectedKategori.value = '';
    namaController.clear();
    descriptionController.clear();
    bukaController.clear();
    tutupController.clear();
    alamatController.clear();
    selectedProvinsi.value = ProvinsiDto(id: '', name: '');
    selectedKota.value = KotaDto(id: '', provinceId: '', name: '');
    selectedKecamatan.value = KecamatanDto(id: '', regencyId: '', name: '');
    provinsi.clear();
    kota.clear();
    kecamatan.clear();
    getProvinsiData();
    listPemancinganByUser.clear();
  }

  //Get Pemancingan By User
  Future<void> getDataPemancinganByUser(
      String search, String page, String idUser, String paginate) async {
    try {
      await pemancinganService
          .getPemancinganByUser(search, page, idUser, paginate)
          .then((value) => {
                totalDataPemancinganByUser.value = value.data.total,
                listPemancinganByUser.addAll(value.data.data),
              });
    } catch (e) {
      print('Error fetching Pemancingan by user: $e');
    }
  }

  //Create Pemancingan
  Future<void> createPemancinganData(context) async {
    try {
      if (formDaftar.currentState!.validate() && filePath.isNotEmpty) {
        await authService.getUserDetail().then((value) async {
          final data = CreatePemancinganDto(
            idUser: value.data.id,
            category: selectedKategori.value,
            image: File(filePath.value),
            namaPemancingan: namaController.value.text,
            deskripsi: descriptionController.value.text,
            provinsi: selectedProvinsi.value.name,
            kota: selectedKota.value.name,
            kecamatan: selectedKecamatan.value.name,
            alamat: alamatController.value.text,
            buka: bukaController.value.text,
            tutup: tutupController.value.text,
            longitude: markerLocation.value.longitude.toString(),
            latitude: markerLocation.value.latitude.toString(),
            id_provinsi: int.parse(selectedProvinsi.value.id),
            id_kota: int.parse(selectedKota.value.id),
            id_kecamatan: int.parse(selectedKecamatan.value.id),
          );
          await pemancinganService.createPemancingan(data).then((value) {
            if (value == true) {
              loading.value = true;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text("Registrasi pemancingan berhasil!")));
              layoutController.pemancinganSayaPage();
              resetDropdown();
              listPemancinganByUser.clear();
              getDataPemancinganByUser(
                  searchController.text, '$page', idUser, paginate.toString());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text("Server Internal Error!")));
            }
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Harap isi formulir dengan benar!")));
      }
    } catch (e) {
      print('Error creating Pemancingan: $e');
    }
  }

  //Get Pemancingan by Id
  Future<void> getPemancinganById(int id) async {
    try {
      changeFile.value = false;
      await pemancinganService.getDetailPemancingan(id).then((value) async {
        idPemancingan = value.data.id.toString();
        statusPemancingan.value = value.data.status == null
            ? 'null'
            : value.data.status == 1
                ? '1'
                : '0';
        urlImage.value =
            'http://192.168.102.118:8000/api/images-pemancingan/${value.data.image}';
        namaController.text = value.data.namaPemancingan;
        descriptionController.text = value.data.deskripsi;
        alamatController.text = value.data.alamat;
        bukaController.text = value.data.buka;
        tutupController.text = value.data.tutup;
        markerLocation = LatLng(double.parse(value.data.latitude),
                double.parse(value.data.longitude))
            .obs;
        selectedKategori.value = value.data.category;
        selectedProvinsi.value =
            ProvinsiDto(id: value.data.idProvinsi, name: value.data.provinsi);
        getKotaData(value.data.idProvinsi);
        selectedKota.value = KotaDto(
            id: value.data.idKota,
            provinceId: value.data.idProvinsi,
            name: value.data.kota);
        getKecamatanData(value.data.idKota);
        selectedKecamatan.value = KecamatanDto(
            id: value.data.idKecamatan,
            regencyId: value.data.idKota,
            name: value.data.kecamatan);
        // resetDropdown();
        layoutController.detailPemancinganPage();
      });
    } catch (e) {
      print('Error getting Pemancingan: $e');
    }
  }

  //Create Pemancingan
  Future<void> updatePemancinganData(context) async {
    try {
      loading.value = false;
      if (formDaftar.currentState!.validate()) {
        if (loading.value == false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.blue,
              content: Text("Update sedang berlansung...")));
        }
        await authService.getUserDetail().then((value) async {
          String imageUrl = urlImage.value;
          final imageFilePath =
              await pemancinganService.downloadImage(imageUrl);
          final data = CreatePemancinganDto(
            idUser: value.data.id,
            category: selectedKategori.value,
            image: changeFile.value == true
                ? File(filePath.value)
                : File(imageFilePath),
            namaPemancingan: namaController.value.text,
            deskripsi: descriptionController.value.text,
            provinsi: selectedProvinsi.value.name,
            kota: selectedKota.value.name,
            kecamatan: selectedKecamatan.value.name,
            alamat: alamatController.value.text,
            buka: bukaController.value.text,
            tutup: tutupController.value.text,
            longitude: markerLocation.value.longitude.toString(),
            latitude: markerLocation.value.latitude.toString(),
            id_provinsi: int.parse(selectedProvinsi.value.id),
            id_kota: int.parse(selectedKota.value.id),
            id_kecamatan: int.parse(selectedKecamatan.value.id),
          );
          await pemancinganService
              .updatePemancingan(data, idPemancingan)
              .then((value) {
            if (value == true) {
              loading.value = true;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text("Update pemancingan berhasil!")));
              layoutController.pemancinganSayaPage();
              resetDropdown();
              getDataPemancinganByUser(
                  searchController.text, '$page', idUser, paginate.toString());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text("Server Internal Error!")));
            }
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Harap isi formulir dengan benar!")));
      }
    } catch (e) {
      print('Error updating Pemancingan: $e');
    }
  }

  void getPemancinganAll() async {
    listPemancinganByUser.clear();
    page = 1;
    await getDetailUser().then((value) {
      getDataPemancinganByUser(
              searchController.text, '$page', idUser, paginate.toString())
          .then((value) => loading.value = true);
    });
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Back again to exit");
      statusDesc.value = false;
      return false;
    }
    Get.back();
    return true;
  }

  Future<bool> backToPemancingan() async {
    layoutController.pemancinganSayaPage();
    resetDropdown();
    getPemancinganAll();
    return false;
  }

  Future<void> updateStatusPemancingan(
      int id, String status, String pesan) async {
    await pemancinganService.updateStatusPemancingan(id, status, pesan);
    ;
  }
}
