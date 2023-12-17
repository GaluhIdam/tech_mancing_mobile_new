import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/models/list.acara.dto.dart';
import 'package:tech_mancing/app/modules/Acara/services/acara.service.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/list-pemancingan.dart';

class AcaraUserController extends GetxController {
  final AcaraService acaraService = Get.put(AcaraService());
  final LayoutController layoutController = Get.put(LayoutController());
  final AuthService authService = Get.put(AuthService());

  final GlobalKey<FormState> formDaftar = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController grandPrizeController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  final Rx<String> pemancinganSelected = ''.obs;
  final Rx<String> pemancinganSelectedId = ''.obs;

  String idUser = '';
  Rx<String> idAcaras = ''.obs;

  final List<DatumListAcara> listAcara = <DatumListAcara>[].obs;
  DatumListPemancingan? detailAcara;
  Rx<int> totalDataAcara = 0.obs;

  Rx<String> urlImage = ''.obs;

  RxBool loading = false.obs;
  RxBool loadingMore = true.obs;

  RxString formattedDate = ''.obs;

  //Image
  Rx<String> filePath = ''.obs;
  Rx<File>? selectedImage;
  Rx<bool> changeFile = false.obs;

  var page = 1;
  var paginate = 10;

  @override
  void onInit() {
    super.onInit();
    getDataAcara(searchController.text, '${page}', '${paginate}')
        .then((value) => loading.value = true);

    scrollController.addListener(() {
      loading.value = false;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getDataAcara(searchController.text, '$page', '$paginate')
            .then((value) => loading.value = true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getDataAcara(String search, String page, String paginate) async {
    try {
      await acaraService
          .getAcaraForUser(search, page, paginate)
          .then((value) => {
                listAcara.addAll(value.data.data),
                totalDataAcara.value = value.data.total,
              });
    } catch (e) {
      throw e;
    }
  }

  Future<void> getAcaraById(int idAcara) async {
    try {
      idAcaras.value = idAcara.toString();
      await acaraService.getAcaraById(idAcara).then((value) => {
            detailAcara = value.data.pemancinganAcara,
            pemancinganSelected.value =
                value.data.pemancinganAcara.namaPemancingan,
            pemancinganSelectedId.value = value.data.idPemancingan.toString(),
            urlImage.value =
                'http://192.168.102.118:8000/api/images-acara/${value.data.gambar}',
            namaController.text = value.data.namaAcara,
            descriptionController.text = value.data.deskripsi,
            startDateController.text =
                DateFormat('yyyy-MM-dd').format(value.data.mulai),
            endDateController.text =
                DateFormat('yyyy-MM-dd').format(value.data.akhir),
            grandPrizeController.text = value.data.grandPrize,
            layoutController.acaraDetailUserPage(),
            formatGrandPrize()
          });
    } catch (e) {
      print('Error fetching detail acara data: $e');
    }
  }

  void formatGrandPrize() {
    String enteredValue = grandPrizeController.text.replaceAll(',', '');
    if (enteredValue.isNotEmpty) {
      int intValue = int.parse(enteredValue);
      grandPrizeController.text =
          NumberFormat.decimalPattern('en_US').format(intValue);
      grandPrizeController.selection = TextSelection.fromPosition(
          TextPosition(offset: grandPrizeController.text.length));
    }
  }

  Future<bool> backToAcara() async {
    layoutController.acaraUserPage();
    return false;
  }

  void getAcaraAll() async {
    listAcara.clear();
    page = 1;
    await getDataAcara(searchController.text, '$page', '$paginate')
        .then((value) => loading.value = true);
  }
}
