import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';

class AcaraDetailView extends StatelessWidget {
  AcaraDetailView({super.key});

  final PemancinganSayaContoller controller =
      Get.put(PemancinganSayaContoller());
  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraController acaraController = Get.put(AcaraController());
  final PemancinganSayaContoller pemancinganController =
      Get.put(PemancinganSayaContoller());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: ListView(
              children: [
                Form(
                    key: acaraController.formDaftar,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                  acaraController
                                      .urlImage.value, // Your image URL
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
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            child: ElevatedButton(
                              onPressed: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      acaraController.pickFile(context);
                                    }
                                  : null,
                              child: const Text('Pilih Gambar'),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Nama Acara :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              enabled: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? true
                                  : false,
                              keyboardType: TextInputType.name,
                              controller: acaraController.namaController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silakan ketik nama acara';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: "e.g Lomba mancing 17 agustus"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Deskripsi :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              enabled: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? true
                                  : false,
                              keyboardType: TextInputType.name,
                              controller: acaraController.descriptionController,
                              maxLines: 5,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silakan ketik deskripsi';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText:
                                      "e.g acara memperingati kemerdekaan"),
                            ),
                          ),

                          //Mulai & Selesai
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Mulai :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              enabled: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? true
                                  : false,
                              controller: acaraController.startDateController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(acaraController
                                        .startDateController.text),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  acaraController.startDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                }
                              },
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Akhir :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              enabled: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? true
                                  : false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Masukkan tanggal akhir';
                                }
                                if (DateTime.parse(
                                        acaraController.endDateController.text)
                                    .isBefore(DateTime.parse(acaraController
                                        .startDateController.text))) {
                                  return 'Masukkan tanggal akhir tidak boleh kurang dari tanggal mulai';
                                }

                                return null;
                              },
                              controller: acaraController.endDateController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(
                                        acaraController.endDateController.text),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  acaraController.endDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                }
                              },
                            ),
                          ),

                          //Grand Prize
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Grand Prize :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              enabled: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? true
                                  : false,
                              keyboardType: TextInputType.number,
                              controller: acaraController.grandPrizeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silakan ketik grand prize';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                acaraController.formatGrandPrize();
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: "Rp."),
                            ),
                          ),

                          //Provinsi
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Pilih Pemancingan Anda :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Obx(
                                () => DropdownButtonFormField(
                                  isExpanded: true,
                                  items: pemancinganController
                                      .listPemancinganByUser
                                      .map((value) => DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text(value.namaPemancingan),
                                          ))
                                      .toList(),
                                  onChanged: (dynamic selectedValue) {
                                    acaraController.pemancinganSelectedId
                                        .value = selectedValue.id.toString();
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Text(
                                      acaraController
                                                  .pemancinganSelected.value ==
                                              ''
                                          ? 'Pilih pemancingan anda'
                                          : acaraController
                                              .pemancinganSelected.value
                                              .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(4, 99, 128, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: DateTime.now().isBefore(DateTime.parse(
                                      acaraController.startDateController.text))
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      acaraController.updateAcaraData(context,
                                          acaraController.idAcaras.value);
                                    }
                                  : null,
                              child: Center(
                                child: DateTime.parse(acaraController
                                            .startDateController.text)
                                        .isAfter(DateTime.now())
                                    ? const Text(
                                        "Ubah",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Acara Telah Berlangsung",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 159, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (loginController.userData.value.role ==
                                    'user') {
                                  layoutController.acaraSayaPage();
                                } else {
                                  layoutController.acaraUserPage();
                                }
                                acaraController.getAcaraAll();
                                acaraController.clearForm();
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
                    ))
              ],
            ),
          ),
        ),
        onWillPop: () async => await acaraController.backToAcara());
  }
}
