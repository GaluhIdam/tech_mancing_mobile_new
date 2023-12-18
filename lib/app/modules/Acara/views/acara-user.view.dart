import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara-user.controller.dart';
import 'package:tech_mancing/app/modules/Acara/widgets/event-user.widget.dart';
import 'package:tech_mancing/app/modules/Acara/widgets/event.widget.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';

class AcaraUserView extends StatelessWidget {
  AcaraUserView({super.key});

  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraUserController acaraController = Get.put(AcaraUserController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight:
              loginController.userData.value.role == 'admin' ? 130.0 : 100.0,
          backgroundColor: Colors.transparent,
          title: Column(
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
                            margin: const EdgeInsets.only(left: 2, right: 2),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: acaraController
                                              .filter.value ==
                                          'null'
                                      ? Color.fromARGB(255, 140, 145, 0)
                                      : const Color.fromRGBO(215, 223, 0, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  acaraController.listAcara.clear();
                                  acaraController.loading.value = false;
                                  acaraController.filter.value = 'null';
                                  acaraController
                                      .getAcaraAdmin(
                                          'null',
                                          acaraController.searchController.text,
                                          acaraController.page.toString(),
                                          acaraController.paginate.toString())
                                      .then((value) =>
                                          acaraController.loading.value = true);
                                },
                                child: Text(
                                    "${acaraController.waiting.value.toString()} Menunggu Persetujuan")),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2, right: 2),
                            child: ElevatedButton(
                                onPressed: () {
                                  acaraController.listAcara.clear();
                                  acaraController.loading.value = false;
                                  acaraController.filter.value = '1';
                                  acaraController
                                      .getAcaraAdmin(
                                          '1',
                                          acaraController.searchController.text,
                                          acaraController.page.toString(),
                                          acaraController.paginate.toString())
                                      .then((value) =>
                                          acaraController.loading.value = true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      acaraController.filter.value == '1'
                                          ? const Color.fromARGB(255, 2, 114, 0)
                                          : const Color.fromRGBO(3, 165, 0, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                    "${acaraController.approve.value.toString()} Disetujui")),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2, right: 2),
                            child: ElevatedButton(
                                onPressed: () {
                                  acaraController.listAcara.clear();
                                  acaraController.loading.value = false;
                                  acaraController.filter.value = '0';
                                  acaraController
                                      .getAcaraAdmin(
                                          '0',
                                          acaraController.searchController.text,
                                          acaraController.page.toString(),
                                          acaraController.paginate.toString())
                                      .then((value) =>
                                          acaraController.loading.value = true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      acaraController.filter.value == '0'
                                          ? Color.fromARGB(255, 112, 0, 0)
                                          : const Color.fromRGBO(177, 0, 0, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                    "${acaraController.reject.value.toString()} DiTolak")),
                          )
                        ],
                      ),
                    )),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  controller: acaraController.searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    acaraController.loading.value = false;
                  },
                  onEditingComplete: () {
                    acaraController.listAcara.clear();
                    acaraController.getAcaraAll();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: const InputDecoration(
                    labelText: "cari acara terdekat...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "e.g lomba mancing",
                  ),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          child: ListView(
            children: [
              Obx(() {
                if (acaraController.loading.value == false) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Column(
                    children: acaraController.listAcara.isEmpty
                        ? [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child:
                                  const Text('Tidak ada acara yg terdaftar!'),
                            ),
                          ]
                        : [
                            if (loginController.userData.value.role == 'user')
                              for (var acara in acaraController.listAcara)
                                EventUserWidget(
                                  status: acara.status,
                                  image:
                                      'http://192.168.163.118:8000/api/images-acara/${acara.gambar}',
                                  title: acara.namaAcara,
                                  description: acara.deskripsi,
                                  pemancingan:
                                      acara.pemancinganAcara.namaPemancingan,
                                  mulai: acara.mulai,
                                  selesai: acara.akhir,
                                  grandPrize: int.parse(acara.grandPrize),
                                  idAcara: acara.id,
                                ),
                            if (loginController.userData.value.role == 'admin')
                              for (var acara in acaraController.listAcara)
                                EventWidget(
                                  status: acara.status,
                                  image:
                                      'http://192.168.163.118:8000/api/images-acara/${acara.gambar}',
                                  title: acara.namaAcara,
                                  description: acara.deskripsi,
                                  pemancingan:
                                      acara.pemancinganAcara.namaPemancingan,
                                  mulai: acara.mulai,
                                  selesai: acara.akhir,
                                  grandPrize: int.parse(acara.grandPrize),
                                  idAcara: acara.id,
                                ),
                            Obx(() {
                              if (acaraController.loadingMore.value == false) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                            Obx(() {
                              if (acaraController.totalDataAcara >
                                  acaraController.listAcara.length) {
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
                                      acaraController.page++;
                                      acaraController.loadingMore.value = false;
                                      acaraController
                                          .getDataAcara(
                                            acaraController
                                                .searchController.text,
                                            '${acaraController.page}',
                                            '${acaraController.paginate}',
                                          )
                                          .then((value) => acaraController
                                              .loadingMore.value = true);
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
              }),
            ],
          ),
          onRefresh: () async {
            acaraController.listAcara.clear();
            acaraController.page = 1;
            if (loginController.userData.value.role == 'user') {
              await acaraController
                  .getDataAcara(
                    acaraController.searchController.text,
                    '${acaraController.page}',
                    '${acaraController.paginate}',
                  )
                  .then((value) => acaraController.loading.value = true);
            } else {
              await acaraController.getStatsDataAcara();
              await acaraController.getAcaraAdmin(
                  acaraController.filter.value,
                  acaraController.searchController.text,
                  acaraController.page.toString(),
                  acaraController.paginate.toString());
            }
          },
        ),
      ),
    );
  }
}
