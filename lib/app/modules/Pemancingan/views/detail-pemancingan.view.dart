import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kecamatan.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/kota.dto.dart';
import 'package:tech_mancing/app/modules/Pemancingan/models/provinsi.dto.dart';
import 'dart:math' as math;

class DetailPemancinganView extends StatelessWidget {
  DetailPemancinganView({super.key});
  final PemancinganContoller controller = Get.put(PemancinganContoller());
  final LayoutController layoutController = Get.put(LayoutController());
  final HomeController controllerHome = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView(
                children: [
                  Form(
                      key: controller.formDaftar,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              if (controller.changeFile.value == true) {
                                return SizedBox(
                                  width: double
                                      .infinity, // Set the width to the maximum available width
                                  height: 200.0, // Set the desired height
                                  child: Image.file(
                                    File(controller
                                        .filePath.value), // Your image URL
                                    fit: BoxFit
                                        .cover, // Crop the image to cover the available space
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width: double
                                      .infinity, // Set the width to the maximum available width
                                  height: 200.0, // Set the desired height
                                  child: Image.network(
                                    controller.urlImage.value, // Your image URL
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
                                  controller.pickFile(context);
                                },
                                child: const Text('Pilih Gambar'),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Nama Pemancingan :",
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
                                controller: controller.namaController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Silakan ketik nama pemancingan';
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
                                    hintText: "e.g Pemancingan Pak Slamet"),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: const Text(
                                        "Jam Buka :",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      margin: const EdgeInsets.only(
                                          top: 5, right: 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controller.bukaController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Silakan ketik jam buka';
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
                                            hintText: "00.00"),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: const Text(
                                        "Jam Tutup :",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      margin: const EdgeInsets.only(
                                          top: 5, right: 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controller.tutupController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Silakan ketik jam tutup';
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
                                            hintText: "24.00"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Kategori Pemancingan :",
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
                                  () => DropdownButtonFormField<String>(
                                    validator: (selectedValue) {
                                      if (controller.selectedKategori.isEmpty) {
                                        return 'Mohon pilih kategori!';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    items: controller.kategori.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? selectedValue) {
                                      controller.selectedKategori.value =
                                          selectedValue!;
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                        controller.selectedKategori.value == ''
                                            ? 'Pilih Kategori'
                                            : controller.selectedKategori.value,
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
                                controller: controller.descriptionController,
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
                                        "e.g Pemancingan ini sangat nyaman..."),
                              ),
                            ),

                            //Provinsi
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Provinsi :",
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
                                    validator: (selectedValue) {
                                      if (controller.selectedProvinsi.value.name
                                          .isEmpty) {
                                        return 'Mohon pilih provinsi!';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    items: controller.provinsi.map((value) {
                                      return DropdownMenuItem<ProvinsiDto>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    onChanged: (ProvinsiDto? selectedValue) {
                                      controller.selectedProvinsi.value =
                                          selectedValue!;
                                      controller.getKotaData(selectedValue.id);
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                        controller.selectedProvinsi.value
                                                    .name ==
                                                ''
                                            ? 'Pilih Provinsi'
                                            : controller
                                                .selectedProvinsi.value.name,
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

                            //Kota
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Kota :",
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
                                    validator: (selectedValue) {
                                      if (controller
                                          .selectedKota.value.name.isEmpty) {
                                        return 'Mohon pilih kota!';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    items: controller.kota.map((value) {
                                      return DropdownMenuItem<KotaDto>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    onChanged: (KotaDto? selectedValue) {
                                      controller
                                          .getKecamatanData(selectedValue!.id);
                                      controller.selectedKota.value =
                                          selectedValue;
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                        controller.selectedKota.value.name == ''
                                            ? 'Pilih Kota'
                                            : controller
                                                .selectedKota.value.name,
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

                            //Kecamatan
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Kecamatan :",
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
                                    validator: (selectedValue) {
                                      if (controller.selectedKecamatan.value
                                          .name.isEmpty) {
                                        return 'Mohon pilih kecamatan!';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    items: controller.kecamatan.map((value) {
                                      return DropdownMenuItem<KecamatanDto>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    onChanged: (KecamatanDto? selectedValue) {
                                      controller.selectedKecamatan.value =
                                          selectedValue!;
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(
                                        controller.selectedKecamatan.value
                                                    .name ==
                                                ''
                                            ? 'Pilih Kecamatan'
                                            : controller
                                                .selectedKecamatan.value.name,
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
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Alamat :",
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
                                controller: controller.alamatController,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Silakan ketik alamat';
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
                                    hintText: "e.g Jl. Raya Siliwangi ..."),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Pilih Lokasi Pemancingan :",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              height: 250,
                              child: Obx(
                                () {
                                  if (controllerHome.currentLocation.value ==
                                      null) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return FlutterMap(
                                      mapController:
                                          controllerHome.mapController,
                                      options: MapOptions(
                                        onTap: (tapPosition, point) {
                                          controller.markerLocation.value =
                                              LatLng(point.latitude,
                                                  point.longitude);
                                        },
                                        rotation: (controllerHome
                                                .compassHeading.value *
                                            (math.pi / 180) *
                                            -1),
                                        maxZoom: 18,
                                        minZoom: 4,
                                        center: controller.markerLocation.value,
                                        zoom: 17,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.tech_mancing.app',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                                point: controller.markerLocation
                                                    .value, // Use the marker location from the controller
                                                width: 30,
                                                height: 30,
                                                builder: (context) =>
                                                    const Icon(
                                                        Icons.my_location)),
                                            Marker(
                                              point: LatLng(
                                                controllerHome.currentLocation
                                                    .value!.latitude,
                                                controllerHome.currentLocation
                                                    .value!.longitude,
                                              ),
                                              width: 30,
                                              height: 30,
                                              builder: (context) =>
                                                  RippleAnimation(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 102, 245),
                                                      repeat: true,
                                                      minRadius: 10,
                                                      ripplesCount: 4,
                                                      duration: const Duration(
                                                          milliseconds:
                                                              6 * 200),
                                                      child: Obx(() {
                                                        return Transform.rotate(
                                                          angle: controllerHome
                                                                  .compassHeading
                                                                  .value *
                                                              (math.pi / 180),
                                                          child: Icon(
                                                            controllerHome
                                                                        .startRoute
                                                                        .value ==
                                                                    false
                                                                ? Icons
                                                                    .navigation_rounded
                                                                : Icons
                                                                    .rocket_rounded,
                                                            color: controllerHome
                                                                        .startRoute
                                                                        .value ==
                                                                    false
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    0,
                                                                    117,
                                                                    152)
                                                                : const Color
                                                                    .fromRGBO(
                                                                    211,
                                                                    6,
                                                                    6,
                                                                    1),
                                                            size: 20.0,
                                                          ),
                                                        );
                                                      })),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
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
                                  controller.updatePemancinganData(context);
                                },
                                child: const Center(
                                  child: Text(
                                    "Ubah",
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
                                  backgroundColor:
                                      Color.fromARGB(255, 159, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  controller.resetDropdown();
                                  controller.getPemancinganAll();
                                  layoutController.pemancinganSayaPage();
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
            )),
        onWillPop: () async => await controller.onWillPop());
  }
}
