import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () async => controller.onWillPop(),
          child: Scaffold(
            body: Center(
              child: Obx(
                () {
                  if (controller.currentLocation.value == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return FlutterMap(
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
                        zoom: 17,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.tech_mancing.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                controller.currentLocation.value!.latitude,
                                controller.currentLocation.value!.longitude,
                              ),
                              width: 30,
                              height: 30,
                              builder: (context) => RippleAnimation(
                                  color: const Color.fromARGB(255, 0, 102, 245),
                                  repeat: true,
                                  minRadius: 10,
                                  ripplesCount: 4,
                                  duration:
                                      const Duration(milliseconds: 6 * 200),
                                  child: Obx(() {
                                    return Transform.rotate(
                                      angle: controller.compassHeading.value *
                                          (math.pi / 180),
                                      child: Icon(
                                        controller.startRoute.value == false
                                            ? Icons.navigation_rounded
                                            : Icons.rocket_rounded,
                                        color: controller.startRoute.value ==
                                                false
                                            ? Color.fromARGB(255, 0, 117, 152)
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
                                controller.onWillPop();
                                // Handle when the route is already started
                                // You can add additional logic here if needed
                              }
                            },
                          )),
                    )

                    // Container(
                    //     margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    //     child: FloatingActionButton(
                    //         backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
                    //         onPressed: () {},
                    //         child: Obx(() => Transform.rotate(
                    //             angle: (controller.compassHeading.value *
                    //                 (math.pi / 180) *
                    //                 -1),
                    //             child: Image.asset('assets/compass.jpg')))))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
