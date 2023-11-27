import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/models/create.acara.dto.dart';
import 'package:tech_mancing/app/modules/Acara/models/list.acara.dto.dart';
import 'package:tech_mancing/app/modules/Acara/services/acara.service.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';

class AcaraController extends GetxController {
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
    getDetailUser().then((value) =>
        getDataAcara(searchController.text, '$page', '$paginate', idUser)
            .then((value) => loading.value = true));
    scrollController.addListener(() {
      loading.value = false;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getDetailUser()
            .then((value) => getDataAcara(
                searchController.text, '$page', '$paginate', idUser))
            .then((value) => loading.value = true);
        print('offsie sit');
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //Pick File
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

  Future<void> getDataAcara(
      String search, String page, String paginate, String idUser) async {
    try {
      await this.acaraService.getAcara(search, page, paginate, idUser).then(
          (value) => {
                listAcara.addAll(value.data.data),
                totalDataAcara.value = value.data.total
              });
    } catch (e) {
      print('Error fetching Acara: $e');
    }
  }

  Future<void> getAcaraById(int idAcara) async {
    try {
      idAcaras.value = idAcara.toString();
      await acaraService.getAcaraById(idAcara).then((value) => {
            pemancinganSelected.value =
                value.data.pemancinganAcara.namaPemancingan,
            pemancinganSelectedId.value = value.data.idPemancingan.toString(),
            urlImage.value =
                'http://192.168.212.118:8000/api/images-acara/${value.data.gambar}',
            namaController.text = value.data.namaAcara,
            descriptionController.text = value.data.deskripsi,
            startDateController.text =
                DateFormat('yyyy-MM-dd').format(value.data.mulai),
            endDateController.text =
                DateFormat('yyyy-MM-dd').format(value.data.akhir),
            grandPrizeController.text = value.data.grandPrize,
            layoutController.detailAcaraPage(),
            formatGrandPrize()
          });
    } catch (e) {
      print('Error fetching detail acara data: $e');
    }
  }

  Future<void> createDataAcara(context) async {
    try {
      if (formDaftar.currentState!.validate() && filePath.isNotEmpty) {
        await authService.getUserDetail().then((value) async {
          final data = CreateAcaraDto(
              idPemancingan: pemancinganSelected.value,
              idUser: value.data.id.toString(),
              namaAcara: namaController.text,
              deskripsi: descriptionController.text,
              mulai: DateTime.parse(startDateController.text),
              akhir: DateTime.parse(endDateController.text),
              grandPrize:
                  grandPrizeController.text.replaceAll(',', '').toString(),
              gambar: File(filePath.value));
          await acaraService.createAcara(data).then((value) {
            if (value == true) {
              layoutController.acaraSayaPage();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text("Registrasi acara berhasil!")));
              getAcaraAll();
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
      print(e);
    }
  }

  void clearForm() {
    namaController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    grandPrizeController.clear();
    filePath.value = '';
    pemancinganSelected.value = '';
  }

  void getAcaraAll() async {
    listAcara.clear();
    page = 1;
    await getDetailUser().then((value) =>
        getDataAcara(searchController.text, '$page', '$paginate', idUser)
            .then((value) => loading.value = true));
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

  Future<void> updateAcaraData(context, String id) async {
    try {
      loading.value = false;
      if (formDaftar.currentState!.validate()) {
        if (loading.value == false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.blue,
              content: Text("Update sedang berlansung...")));
        }
        String imageUrl = urlImage.value;
        final imageFilePath = await acaraService.downloadImage(imageUrl);
        final data = CreateAcaraDto(
          idPemancingan: pemancinganSelectedId.value,
          idUser: '',
          namaAcara: namaController.text,
          deskripsi: descriptionController.text,
          mulai: DateTime.parse(startDateController.text),
          akhir: DateTime.parse(endDateController.text),
          grandPrize: grandPrizeController.text.replaceAll(',', '').toString(),
          gambar: changeFile.value == true
              ? File(filePath.value)
              : File(imageFilePath),
        );
        await acaraService.updateAcara(data, id).then((value) {
          if (value == true) {
            loading.value = true;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Update acara berhasil!")));
            layoutController.acaraSayaPage();
            clearForm();
            getAcaraAll();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("Server Internal Error!")));
          }
        });
      }
    } catch (e) {
      print('Error updating Pemancingan: $e');
    }
  }

  Future<bool> backToAcara() async {
    layoutController.acaraSayaPage();
    getAcaraAll();
    clearForm();
    return false;
  }
}
