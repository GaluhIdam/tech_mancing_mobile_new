import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara-user.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-user.controller.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final HomeController homeController = Get.put(HomeController());
  final LayoutController layoutController = Get.put(LayoutController());
  final LoginController loginController = Get.put(LoginController());
  final PemancinganUserController pemancinganUserController =
      Get.put(PemancinganUserController());
  final PemancinganSayaContoller pemancinganSayaContoller =
      Get.put(PemancinganSayaContoller());
  final AcaraController acaraController = Get.put(AcaraController());
  final AcaraUserController acaraUserController =
      Get.put(AcaraUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (loginController.userData.value.role == 'user') {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
                  decoration:
                      const BoxDecoration(color: Color.fromRGBO(4, 99, 128, 1)),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                              child: Text(
                                layoutController.name ?? '-',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            Text(
                              layoutController.email ?? '-',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text("Explorasi"),
                  onTap: () => {
                        layoutController.explorasiPage(),
                        homeController.listPemancingan.clear(),
                        homeController.getDataPemancinganForUser(
                            '',
                            '1',
                            '10',
                            homeController.currentLocation.value!.latitude
                                .toString(),
                            homeController.currentLocation.value!.longitude
                                .toString()),
                      }),
              ListTile(
                leading: const Icon(Icons.phishing),
                title: const Text("Pemancingan"),
                onTap: () => {
                  pemancinganUserController.loading.value = false,
                  pemancinganUserController.getDataPemancinganFU(),
                  layoutController.pemancinganPage()
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Acara"),
                onTap: () {
                  layoutController.acaraUserPage();
                  acaraUserController.loading.value = false;
                  acaraUserController.getAcaraAll();
                },
              ),
              const Divider(
                thickness: 1.0,
              ),
              ListTile(
                leading: const Icon(Icons.phishing),
                title: const Text("Pemancingan Saya"),
                onTap: () => {
                  pemancinganSayaContoller.getPemancinganAll(),
                  layoutController.pemancinganSayaPage()
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Acara Saya"),
                onTap: () => {
                  layoutController.acaraSayaPage(),
                  acaraController.getAcaraAll()
                },
              ),
              const Divider(
                thickness: 1.0,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Keluar"),
                onTap: () => loginController.logout(context),
              ),
            ],
          ),
        );
      } else {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
                  decoration:
                      const BoxDecoration(color: Color.fromRGBO(4, 99, 128, 1)),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                              child: Text(
                                layoutController.name ?? '-',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              layoutController.email ?? '-',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text("Explorasi"),
                  onTap: () => {
                        layoutController.explorasiPage(),
                        homeController.listPemancingan.clear(),
                        homeController.getDataPemancinganForUser(
                            '',
                            '1',
                            '10',
                            homeController.currentLocation.value!.latitude
                                .toString(),
                            homeController.currentLocation.value!.longitude
                                .toString()),
                      }),
              ListTile(
                leading: const Icon(Icons.phishing),
                title: const Text("Pemancingan"),
                onTap: () => {
                  pemancinganUserController.loading.value = false,
                  pemancinganUserController.getDataPemancinganFU(),
                  layoutController.pemancinganPage()
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Acara"),
                onTap: () {
                  layoutController.acaraUserPage();
                  acaraUserController.loading.value = false;
                  acaraUserController.getAcaraAll();
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Keluar"),
                onTap: () => loginController.logout(context),
              ),
            ],
          ),
        );
      }
    });
  }
}
