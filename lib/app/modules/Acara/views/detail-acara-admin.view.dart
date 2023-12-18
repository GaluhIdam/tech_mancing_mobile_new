import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara-user.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';

class AcaraDetailAdminView extends StatelessWidget {
  AcaraDetailAdminView({super.key});

  final PemancinganSayaContoller controller =
      Get.put(PemancinganSayaContoller());
  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraController acaraController = Get.put(AcaraController());
  final AcaraUserController acaraUserController =
      Get.put(AcaraUserController());
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
                              enabled: false,
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
                              enabled: false,
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
                              enabled: false,
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
                              enabled: false,
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
                              enabled: false,
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
                          if (acaraController.pesanController.text.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Pesan DiTolak :",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 192, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (acaraController.pesanController.text.isNotEmpty)
                            Container(
                                margin: const EdgeInsets.only(top: 5),
                                child:
                                    Text(acaraController.pesanController.text)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (acaraController.statusAcara.value == '0' ||
                                  acaraController.statusAcara.value == 'null')
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 8, 159, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      acaraUserController.loading.value = false;
                                      FocusScope.of(context).unfocus();
                                      if (loginController.userData.value.role ==
                                          'user') {
                                        layoutController.acaraSayaPage();
                                      } else {
                                        acaraUserController.listAcara.clear();
                                        acaraController.updateStatusDataAcara(
                                            int.parse(
                                                acaraController.idAcaras.value),
                                            '1',
                                            controller.pesanController.text);
                                        acaraUserController.filter.value = '1';
                                        acaraUserController.getStatsDataAcara();
                                        acaraUserController
                                            .getAcaraAdmin(
                                                acaraUserController
                                                    .filter.value,
                                                acaraUserController
                                                    .searchController.text,
                                                acaraUserController.page
                                                    .toString(),
                                                acaraUserController.paginate
                                                    .toString())
                                            .then((value) => acaraUserController
                                                .loading.value = true);
                                        layoutController.acaraUserPage();
                                      }
                                      acaraController.statusAcara.value =
                                          'false';
                                    },
                                    child: const Center(
                                      child: Text(
                                        "Setujui",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((acaraController.statusAcara.value == '1' ||
                                      acaraController.statusAcara.value ==
                                          'null') &&
                                  acaraController.statusDesc.value == false)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 159, 0, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      acaraController.statusAcara.value =
                                          'true';
                                    },
                                    child: const Center(
                                      child: Text(
                                        "Tolak",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Obx(() {
                            if (acaraController.statusAcara.value == 'true') {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Pesan :",
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
                                      controller: controller.pesanController,
                                      maxLines: 5,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Silakan ketik pesan alasan ditolak !';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: "e.g alamat tidak sesuai!"),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 211, 0, 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        acaraUserController.loading.value =
                                            false;
                                        acaraController.updateStatusDataAcara(
                                            int.parse(
                                                acaraController.idAcaras.value),
                                            '0',
                                            controller.pesanController.text);
                                        acaraUserController.listAcara.clear();
                                        acaraUserController.filter.value = '0';
                                        acaraUserController.getStatsDataAcara();
                                        layoutController.acaraUserPage();
                                        acaraUserController
                                            .getAcaraAdmin(
                                                acaraUserController
                                                    .filter.value,
                                                acaraUserController
                                                    .searchController.text,
                                                acaraUserController.page
                                                    .toString(),
                                                acaraUserController.paginate
                                                    .toString())
                                            .then((value) => acaraUserController
                                                .loading.value = true);
                                        acaraController.statusAcara.value =
                                            'false';
                                      },
                                      child: const Center(
                                        child: Text(
                                          "Tolak",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 90, 90, 90),
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
