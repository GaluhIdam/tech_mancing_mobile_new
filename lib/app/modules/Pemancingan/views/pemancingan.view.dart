import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Home/controllers/home.controller.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-user.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/widgets/card-for-user.widget.dart';

class PemancinganView extends StatelessWidget {
  PemancinganView({super.key});
  final LayoutController layoutController = Get.put(LayoutController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final PemancinganUserController pemancinganUserController =
      Get.put(PemancinganUserController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                toolbarHeight: loginController.userData.value.role == 'admin'
                    ? 130.0
                    : 100.0,
                backgroundColor: Colors.transparent,
                title: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Column(
                      children: [
                        if (loginController.userData.value.role == 'admin')
                          Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Obx(
                                () => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                pemancinganUserController
                                                            .filter.value ==
                                                        'null'
                                                    ? Color.fromARGB(
                                                        255, 140, 145, 0)
                                                    : const Color.fromRGBO(
                                                        215, 223, 0, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            pemancinganUserController
                                                .loading.value = false;
                                            pemancinganUserController
                                                .filter.value = 'null';
                                            pemancinganUserController
                                                .listPemancingan
                                                .clear();
                                            pemancinganUserController
                                                .getDataPemancinganForAdmin(
                                                    'null',
                                                    pemancinganUserController
                                                        .searchController.text,
                                                    pemancinganUserController
                                                        .page
                                                        .toString(),
                                                    pemancinganUserController
                                                        .paginate
                                                        .toString())
                                                .then((value) =>
                                                    pemancinganUserController
                                                        .loading.value = true);
                                          },
                                          child: Text(
                                              "${pemancinganUserController.waiting.value.toString()} Menunggu Persetujuan")),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            pemancinganUserController
                                                .loading.value = false;
                                            pemancinganUserController
                                                .filter.value = '1';
                                            pemancinganUserController
                                                .listPemancingan
                                                .clear();
                                            pemancinganUserController
                                                .getDataPemancinganForAdmin(
                                                    '1',
                                                    pemancinganUserController
                                                        .searchController.text,
                                                    pemancinganUserController
                                                        .page
                                                        .toString(),
                                                    pemancinganUserController
                                                        .paginate
                                                        .toString())
                                                .then((value) =>
                                                    pemancinganUserController
                                                        .loading.value = true);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                pemancinganUserController
                                                            .filter.value ==
                                                        '1'
                                                    ? const Color.fromARGB(
                                                        255, 2, 114, 0)
                                                    : const Color.fromRGBO(
                                                        3, 165, 0, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                              "${pemancinganUserController.approve.value.toString()} Disetujui")),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            pemancinganUserController
                                                .loading.value = false;
                                            pemancinganUserController
                                                .filter.value = '0';
                                            pemancinganUserController
                                                .listPemancingan
                                                .clear();
                                            pemancinganUserController
                                                .getDataPemancinganForAdmin(
                                                    '0',
                                                    pemancinganUserController
                                                        .searchController.text,
                                                    pemancinganUserController
                                                        .page
                                                        .toString(),
                                                    pemancinganUserController
                                                        .paginate
                                                        .toString())
                                                .then((value) =>
                                                    pemancinganUserController
                                                        .loading.value = true);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                pemancinganUserController
                                                            .filter.value ==
                                                        '0'
                                                    ? Color.fromARGB(
                                                        255, 112, 0, 0)
                                                    : const Color.fromRGBO(
                                                        177, 0, 0, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                              "${pemancinganUserController.reject.value.toString()} DiTolak")),
                                    )
                                  ],
                                ),
                              )),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller:
                              pemancinganUserController.searchController,
                          onEditingComplete: () async {
                            pemancinganUserController.loading.value = false;
                            FocusManager.instance.primaryFocus?.unfocus();
                            pemancinganUserController.listPemancingan.clear();
                            if (loginController.userData.value.role == 'user') {
                              await pemancinganUserController
                                  .getDataPemancinganForUser(
                                      pemancinganUserController
                                          .searchController.text,
                                      pemancinganUserController.page.toString(),
                                      pemancinganUserController.paginate
                                          .toString(),
                                      homeController
                                          .currentLocation.value!.latitude
                                          .toString(),
                                      homeController
                                          .currentLocation.value!.longitude
                                          .toString())
                                  .then((value) => pemancinganUserController
                                      .loading.value = true);
                            } else {
                              await pemancinganUserController
                                  .getDataPemancinganForAdmin(
                                      pemancinganUserController.filter.value,
                                      pemancinganUserController
                                          .searchController.text,
                                      pemancinganUserController.page.toString(),
                                      pemancinganUserController.paginate
                                          .toString())
                                  .then((value) => pemancinganUserController
                                      .loading.value = true);
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: "cari pemancingan terdekat...",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: "e.g pemancingan pamulang 86"),
                        ),
                      ],
                    )),
              ),
              body: RefreshIndicator(
                  child: ListView(children: [
                    Obx(() {
                      if (pemancinganUserController.loading.value == false) {
                        return Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return Column(
                          children: pemancinganUserController
                                  .listPemancingan.isEmpty
                              ? [
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                        'Tidak ada pemancingan yg tersedia!'),
                                  ),
                                ]
                              : [
                                  for (var pemancingan
                                      in pemancinganUserController
                                          .listPemancingan)
                                    CardForUserWidget(
                                      pesan: pemancingan.pesan,
                                      image:
                                          'http://192.168.163.118:8000/api/images-pemancingan/${pemancingan.image}',
                                      title: pemancingan.namaPemancingan,
                                      alamat: pemancingan.alamat,
                                      mulai: pemancingan.buka,
                                      selesai: pemancingan.tutup,
                                      kategori: pemancingan.category,
                                      kecamatan: pemancingan.kecamatan,
                                      kota: pemancingan.kota,
                                      provinsi: pemancingan.provinsi,
                                      id: pemancingan.id,
                                      meter: pemancinganUserController
                                          .calculateDistance(
                                              homeController.currentLocation
                                                  .value!.latitude,
                                              homeController.currentLocation
                                                  .value!.longitude,
                                              double.parse(
                                                  pemancingan.latitude),
                                              double.parse(
                                                  pemancingan.longitude)),
                                      rate: pemancinganUserController
                                          .calculateAverageRating(
                                              pemancingan.komentarPemancingan),
                                      status: pemancingan.status,
                                      role: loginController.userData.value.role,
                                    ),
                                  Obx(() {
                                    if (pemancinganUserController
                                            .loadingMore.value ==
                                        false) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(top: 20.0),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                                  Obx(() {
                                    if (pemancinganUserController
                                            .totalDataPemancingan >
                                        pemancinganUserController
                                            .listPemancingan.length) {
                                      return Center(
                                          child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.transparent)),
                                          onPressed: () {
                                            pemancinganUserController.page++;
                                            pemancinganUserController
                                                .loadingMore.value = false;
                                            if (loginController
                                                    .userData.value.role ==
                                                'user') {
                                              pemancinganUserController
                                                  .getDataPemancinganForUser(
                                                      pemancinganUserController
                                                          .searchController
                                                          .text,
                                                      pemancinganUserController.page
                                                          .toString(),
                                                      pemancinganUserController
                                                          .paginate
                                                          .toString(),
                                                      homeController
                                                          .currentLocation
                                                          .value!
                                                          .latitude
                                                          .toString(),
                                                      homeController
                                                          .currentLocation
                                                          .value!
                                                          .longitude
                                                          .toString())
                                                  .then((value) =>
                                                      pemancinganUserController
                                                          .loading
                                                          .value = true);
                                            } else {
                                              pemancinganUserController
                                                  .getDataPemancinganForAdmin(
                                                      pemancinganUserController
                                                          .filter.value,
                                                      pemancinganUserController
                                                          .searchController
                                                          .text,
                                                      pemancinganUserController
                                                          .page
                                                          .toString(),
                                                      pemancinganUserController
                                                          .paginate
                                                          .toString())
                                                  .then((value) =>
                                                      pemancinganUserController
                                                          .loading
                                                          .value = true);
                                            }
                                          },
                                          child: const Text(
                                            'Tampilkan data',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ));
                                    } else {
                                      return const SizedBox();
                                    }
                                  })
                                ],
                        );
                      }
                    })
                  ]),
                  onRefresh: () async {
                    pemancinganUserController.listPemancingan.clear();
                    pemancinganUserController.page = 1;
                    pemancinganUserController.loading.value = false;
                    if (loginController.userData.value.role == 'user') {
                      await pemancinganUserController
                          .getDataPemancinganForUser(
                              pemancinganUserController.searchController.text,
                              pemancinganUserController.page.toString(),
                              pemancinganUserController.paginate.toString(),
                              homeController.currentLocation.value!.latitude
                                  .toString(),
                              homeController.currentLocation.value!.longitude
                                  .toString())
                          .then((value) =>
                              pemancinganUserController.loading.value = true);
                    } else {
                      await pemancinganUserController.getStatsDataPemancingan();
                      await pemancinganUserController
                          .getDataPemancinganForAdmin(
                              pemancinganUserController.filter.value,
                              pemancinganUserController.searchController.text,
                              pemancinganUserController.page.toString(),
                              pemancinganUserController.paginate.toString())
                          .then((value) =>
                              pemancinganUserController.loading.value = true);
                    }
                  })),
        ),
        onWillPop: () async => await pemancinganUserController.onWillPop());
  }
}
