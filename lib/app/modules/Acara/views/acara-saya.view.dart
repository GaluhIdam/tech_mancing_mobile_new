import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';
import 'package:tech_mancing/app/modules/Acara/widgets/event.widget.dart';

class AcaraSayaView extends StatelessWidget {
  AcaraSayaView({Key? key}) : super(key: key);

  final LayoutController layoutController = Get.put(LayoutController());
  final AcaraController acaraController = Get.put(AcaraController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 120.0,
          backgroundColor: Colors.transparent,
          title: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(4, 99, 128, 1)),
                  ),
                  onPressed: () {
                    layoutController.daftarAcaraSayaPage();
                  },
                  child: const Text('Daftarkan Acara'),
                ),
              ),
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
                    acaraController.getDetailUser().then((value) {
                      acaraController
                          .getDataAcara(
                            acaraController.searchController.text,
                            '${acaraController.page}',
                            '${acaraController.paginate}',
                            acaraController.idUser,
                          )
                          .then(
                              (value) => acaraController.loading.value = true);
                    });
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
                                return const SizedBox();
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
                                            acaraController.idUser,
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
            await acaraController
                .getDetailUser()
                .then((value) => acaraController
                    .getDataAcara(
                      acaraController.searchController.text,
                      '${acaraController.page}',
                      '${acaraController.paginate}',
                      acaraController.idUser,
                    )
                    .then((value) => acaraController.loading.value = true));
          },
        ),
      ),
    );
  }
}
