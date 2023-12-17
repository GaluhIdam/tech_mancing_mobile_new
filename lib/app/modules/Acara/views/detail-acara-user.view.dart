import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara-user.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-detail.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';

class DetailAcaraUserView extends StatelessWidget {
  DetailAcaraUserView({super.key});

  final PemancinganSayaContoller controller =
      Get.put(PemancinganSayaContoller());
  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraUserController acaraController = Get.put(AcaraUserController());
  final PemancinganSayaContoller pemancinganController =
      Get.put(PemancinganSayaContoller());
  final PemancinganDetailController pemancinganDetailContoller =
      Get.put(PemancinganDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (acaraController.filePath.value == '') {
                          return SizedBox(
                            width: double
                                .infinity, // Set the width to the maximum available width
                            height: 200.0, // Set the desired height
                            child: Image.network(
                              acaraController.urlImage.value, // Your image URL
                              fit: BoxFit
                                  .cover, // Crop the image to cover the available space
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: double
                                .infinity, // Set the width to the maximum available width
                            height: 200.0, // Set the desired height
                            child: Image.file(
                              File(acaraController
                                  .filePath.value), // Your image URL
                              fit: BoxFit
                                  .cover, // Crop the image to cover the available space
                            ),
                          );
                        }
                      }),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          acaraController.namaController.text,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Text(
                          acaraController.descriptionController.text,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Text(
                          'Mulai : ${acaraController.startDateController.text} - ${acaraController.endDateController.text}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Text(
                          'Grand Prize : Rp. ${acaraController.grandPrizeController.text}',
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 25),
                        child: const Text(
                          'Lokasi Pemancingan :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Text(
                          acaraController.detailAcara!.namaPemancingan,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          acaraController.detailAcara!.alamat,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      pemancinganDetailContoller
                          .getPemancinganById(acaraController.detailAcara!.id);
                    },
                    child: const Center(
                      child: Text(
                        "Lihat Pemancingan",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 159, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      acaraController.loading.value = false;
                      acaraController.getAcaraAll();
                      layoutController.acaraUserPage();
                    },
                    child: const Center(
                      child: Text(
                        "Kembali",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => await acaraController.backToAcara());
  }
}
