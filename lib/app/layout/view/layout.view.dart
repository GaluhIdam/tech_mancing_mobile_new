import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/layout/widgets/drawer.widget.dart';
import 'package:tech_mancing/app/modules/Acara/views/acara-saya.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/acara-user.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/daftar-acara.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/detail-acara-user.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/detail-acara-view.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/daftar-pemacingan.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/detail-pemancingan-for-user.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/detail-pemancingan.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/pemancingan-saya.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/pemancingan.view.dart';
import 'package:tech_mancing/app/routes/routes.dart';
import '../../modules/Home/views/home.view.dart';

class LayoutView extends StatelessWidget {
  LayoutView({super.key});

  final LayoutController layoutController = Get.put(LayoutController());
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
            title: Wrap(
              children: [
                Obx(() => layoutController.myIcon.value!),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Obx(() => Text(layoutController.title.value)),
                ),
              ],
            ),
            centerTitle: true,
          ),
          drawer: DrawerWidget(),
          body: Obx(() {
            switch (layoutController.currentRoute.value) {
              case AppRoutes.home:
                controller.startRoute.value = false;
                return HomeView();

              case AppRoutes.acara:
                controller.startRoute.value = false;
                return AcaraSayaView();

              case AppRoutes.acaraUser:
                controller.startRoute.value = false;
                return AcaraUserView();

              case AppRoutes.detailAcaraUser:
                controller.startRoute.value = false;
                return DetailAcaraUserView();

              case AppRoutes.daftarAcara:
                controller.startRoute.value = false;
                return DaftarAcaraView();

              case AppRoutes.detailAcara:
                controller.startRoute.value = false;
                return AcaraDetailView();

              case AppRoutes.pemancingan:
                controller.startRoute.value = false;
                return PemancinganView();

              case AppRoutes.pemancinganSaya:
                controller.startRoute.value = false;
                return PemancinganSayaView();

              case AppRoutes.daftarPemancingan:
                controller.startRoute.value = false;
                return DaftarPemancinganView();

              case AppRoutes.detailPemancingan:
                controller.startRoute.value = false;
                return DetailPemancinganView();
              case AppRoutes.detailUserPemancingan:
                controller.startRoute.value = false;
                return DetailPemancinganForUserView();

              default:
                return HomeView();
            }
          }),
        ));
  }
}
