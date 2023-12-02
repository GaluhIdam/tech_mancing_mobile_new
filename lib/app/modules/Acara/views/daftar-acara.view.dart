import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';

class DaftarAcaraView extends StatelessWidget {
  DaftarAcaraView({super.key});

  final PemancinganSayaContoller controller =
      Get.put(PemancinganSayaContoller());
  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraController acaraController = Get.put(AcaraController());
  final PemancinganSayaContoller pemancinganController =
      Get.put(PemancinganSayaContoller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Pendaftaran Acara",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(4, 99, 128, 1)),
                  ),
                ),
                Form(
                    key: acaraController.formDaftar,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (acaraController.filePath.value == '') {
                              return SizedBox(
                                width: double
                                    .infinity, // Set the width to the maximum available width
                                height: 200.0, // Set the desired height
                                child: Image.asset(
                                  'assets/pemancingan-default.jpg', // Your image URL
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
                              onPressed: () {
                                acaraController.pickFile(context);
                              },
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
                              controller: acaraController.startDateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Masukkan tanggal mulai';
                                }
                                if (DateTime.parse(
                                        acaraController.endDateController.text)
                                    .isBefore(DateTime.parse(acaraController
                                        .startDateController.text))) {
                                  return 'Masukkan tanggal mulai tidak boleh kurang dari tanggal mulai';
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
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(pickedDate);
                                  acaraController.startDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(formattedDate);
                                } else {
                                  print("Date is not selected");
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
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  acaraController.endDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(pickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(formattedDate);
                                } else {
                                  print("Date is not selected");
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
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Silakan pilih pemancingan';
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  items: pemancinganController
                                      .listPemancinganByUser
                                      .map((value) => DropdownMenuItem<dynamic>(
                                            value: value.id,
                                            child: Text(value.namaPemancingan),
                                          ))
                                      .toList(),
                                  onChanged: (dynamic selectedValue) {
                                    acaraController.pemancinganSelected.value =
                                        selectedValue.toString();
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
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                acaraController.createDataAcara(context);
                              },
                              child: const Center(
                                child: Text(
                                  "Daftar",
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
                                acaraController.getAcaraAll();
                                layoutController.acaraSayaPage();
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
