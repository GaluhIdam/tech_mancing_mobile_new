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
    return Drawer(
      child: Obx(() {
        if (loginController.userData.value.role == 'user') {
          return ListView(
            children: [
              DrawerHeader(
                  decoration:
                      const BoxDecoration(color: Color.fromRGBO(4, 99, 128, 1)),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg'),
                          backgroundColor: Colors.white,
                          radius: 35.0,
                        ),
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
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                              padding: const EdgeInsets.fromLTRB(0, 2, 5, 0),
                              child: SizedBox(
                                width: 60, // Set the desired width
                                height: 20, // Set the desired height
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.blue.shade50),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white, // Background color
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0), // Adjust the radius value as needed
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(4, 99, 128, 1),
                                    ),
                                  ),
                                ),
                              ),
                            )
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
          );
        } else {
          return ListView(
            children: [
              DrawerHeader(
                  decoration:
                      const BoxDecoration(color: Color.fromRGBO(4, 99, 128, 1)),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg'),
                          backgroundColor: Colors.white,
                          radius: 35.0,
                        ),
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
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                              padding: const EdgeInsets.fromLTRB(0, 2, 5, 0),
                              child: SizedBox(
                                width: 60, // Set the desired width
                                height: 20, // Set the desired height
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.blue.shade50),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white, // Background color
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0), // Adjust the radius value as needed
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(4, 99, 128, 1),
                                    ),
                                  ),
                                ),
                              ),
                            )
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
          );
        }
      }),
    );
  }
}
