import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:tech_mancing/app/modules/Home/widgets/card-view.widget.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-user.controller.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());
  final PemancinganUserController pemancinganUserController =
      Get.put(PemancinganUserController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => controller.onWillPop(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Center(
              child: Obx(
                () {
                  if (controller.currentLocation.value == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Stack(
                      children: [
                        FlutterMap(
                          mapController: controller.mapController,
                          options: MapOptions(
                            rotation: (controller.compassHeading.value *
                                (math.pi / 180) *
                                -1),
                            maxZoom: 18,
                            minZoom: 4,
                            center: LatLng(
                              controller.currentLocation.value!.latitude,
                              controller.currentLocation.value!.longitude,
                            ),
                            zoom: 16,
                          ),
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              child: TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.tech_mancing.app',
                                tileProvider:
                                    FMTC.instance('mapStore').getTileProvider(),
                              ),
                            ),
                            MarkerLayer(
                              markers: [
                                for (var pemancingan
                                    in controller.listPemancingan)
                                  Marker(
                                      width: 100.0,
                                      height: 100.0,
                                      rotate: true,
                                      rotateAlignment: Alignment.center,
                                      point: LatLng(
                                        double.parse(pemancingan.latitude),
                                        double.parse(pemancingan.longitude),
                                      ),
                                      builder: (context) => Column(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            20.0)),
                                                          ),
                                                          child: SizedBox(
                                                            height: 425,
                                                            child:
                                                                CardViewWidget(
                                                              image:
                                                                  'http://192.168.102.118:8000/api/images-pemancingan/${pemancingan.image}',
                                                              title: pemancingan
                                                                  .namaPemancingan,
                                                              alamat:
                                                                  pemancingan
                                                                      .alamat,
                                                              mulai: pemancingan
                                                                  .buka,
                                                              selesai:
                                                                  pemancingan
                                                                      .tutup,
                                                              kategori:
                                                                  pemancingan
                                                                      .category,
                                                              kecamatan:
                                                                  pemancingan
                                                                      .kecamatan,
                                                              kota: pemancingan
                                                                  .kota,
                                                              provinsi:
                                                                  pemancingan
                                                                      .provinsi,
                                                              id: pemancingan
                                                                  .id,
                                                              meter: pemancinganUserController.calculateDistance(
                                                                  controller
                                                                      .currentLocation
                                                                      .value!
                                                                      .latitude,
                                                                  controller
                                                                      .currentLocation
                                                                      .value!
                                                                      .longitude,
                                                                  double.parse(
                                                                      pemancingan
                                                                          .latitude),
                                                                  double.parse(
                                                                      pemancingan
                                                                          .longitude)),
                                                              rate: pemancinganUserController
                                                                  .calculateAverageRating(
                                                                      pemancingan
                                                                          .komentarPemancingan),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.location_pin,
                                                    size: 30.0,
                                                    color: Colors.green,
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.3), // Adjust the color and opacity of the shadow
                                                        blurRadius:
                                                            3.0, // Adjust the blur radius of the shadow
                                                        offset: const Offset(
                                                            1.0,
                                                            1.0), // Adjust the offset of the shadow
                                                      ),
                                                    ],
                                                  )),
                                              Text(
                                                pemancingan.namaPemancingan,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ],
                                          )),
                                Marker(
                                  point: LatLng(
                                    controller.currentLocation.value!.latitude,
                                    controller.currentLocation.value!.longitude,
                                  ),
                                  width: 30,
                                  height: 30,
                                  builder: (context) => RippleAnimation(
                                      color: const Color.fromARGB(
                                          255, 0, 102, 245),
                                      repeat: true,
                                      minRadius: 10,
                                      ripplesCount: 4,
                                      duration:
                                          const Duration(milliseconds: 6 * 200),
                                      child: Obx(() {
                                        return Transform.rotate(
                                          angle:
                                              controller.compassHeading.value *
                                                  (math.pi / 180),
                                          child: Icon(
                                            controller.startRoute.value == false
                                                ? Icons.navigation_rounded
                                                : Icons.rocket_rounded,
                                            color:
                                                controller.startRoute.value ==
                                                        false
                                                    ? const Color.fromARGB(
                                                        255, 0, 117, 152)
                                                    : const Color.fromRGBO(
                                                        211, 6, 6, 1),
                                            size: 20.0,
                                          ),
                                        );
                                      })),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                            top:
                                20.0, // Sesuaikan posisi input sesuai kebutuhan
                            left: 16.0,
                            right: 16.0,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    focusNode: controller.focusNode,
                                    controller: controller.searchController,
                                    onEditingComplete: () {
                                      controller.loading.value = true;
                                      controller.listPemancinganSearch.clear();
                                      controller.onSearchQueryChanged(
                                          controller.searchController.text);
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Cari Pemancingan...',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 16.0),
                                    ),
                                  ),
                                ),
                                if (controller
                                        .searchController.text.isNotEmpty &&
                                    controller.loading.value == true)
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 20.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      padding: const EdgeInsets.all(16.0),
                                      child: const SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                if (controller
                                        .searchController.text.isNotEmpty &&
                                    controller.loading.value == false &&
                                    controller.listPemancinganSearch.isEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child:
                                          Text('Pemancingan tidak ditemukan!'),
                                    ),
                                  ),
                                if (controller.searchController.text.isNotEmpty &&
                                    controller.loading.value == false &&
                                    controller
                                        .listPemancinganSearch.isNotEmpty &&
                                    controller.focusNode.hasFocus)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: controller.listPemancinganSearch
                                          .map((pemancingan) {
                                        return ElevatedButton(
                                            onPressed: () {
                                              controller.mapController.move(
                                                  LatLng(
                                                      double.parse(
                                                          pemancingan.latitude),
                                                      double.parse(pemancingan
                                                          .longitude)),
                                                  18);
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors
                                                    .transparent // Set the text color
                                                ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          color: Colors.green,
                                                          Icons
                                                              .location_history,
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          '3 meter',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 2),
                                                          child: Text(
                                                            pemancingan
                                                                .namaPemancingan,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5),
                                                          child: Text(
                                                            pemancingan.alamat,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  )
                              ],
                            )),
                      ],
                    );
                  }
                },
              ),
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Obx(() => FloatingActionButton(
                            backgroundColor:
                                controller.startRoute.value == false
                                    ? const Color.fromRGBO(4, 99, 128, 1)
                                    : const Color.fromRGBO(211, 6, 6, 1),
                            child: Icon(controller.startRoute.value == false
                                ? Icons.my_location
                                : Icons.rocket_launch_rounded),
                            onPressed: () async {
                              if (!controller.startRoute.value) {
                                // Start the route
                                controller.startRoute.value = true;
                                controller.getPosition();
                                controller.currentMyLocation();
                              } else {
                                controller.startRoute.value = false;
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
