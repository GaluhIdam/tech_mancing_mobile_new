import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-saya.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/widgets/card-by-user.widget.dart';

class PemancinganSayaView extends StatelessWidget {
  PemancinganSayaView({super.key});
  final LayoutController layoutController = Get.put(LayoutController());
  final PemancinganSayaContoller pemancinganSayaContoller =
      Get.put(PemancinganSayaContoller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
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
                          layoutController.daftarPemancinganPage();
                        },
                        child: const Text('Daftarkan Pemancingan'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        controller: pemancinganSayaContoller.searchController,
                        keyboardType: TextInputType.text,
                        onEditingComplete: () {
                          pemancinganSayaContoller.loading.value = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                          pemancinganSayaContoller.listPemancinganByUser
                              .clear();
                          pemancinganSayaContoller
                              .getDetailUser()
                              .then((value) {
                            pemancinganSayaContoller
                                .getDataPemancinganByUser(
                                  pemancinganSayaContoller
                                      .searchController.text,
                                  '1',
                                  pemancinganSayaContoller.idUser,
                                  pemancinganSayaContoller.paginate.toString(),
                                )
                                .then((value) => pemancinganSayaContoller
                                    .loading.value = true);
                          });
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
                    ),
                  ],
                ),
              ),
              body: RefreshIndicator(
                  child: ListView(children: [
                    Obx(() {
                      if (pemancinganSayaContoller.loading.value == false) {
                        return Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return Column(
                          children: pemancinganSayaContoller
                                  .listPemancinganByUser.isEmpty
                              ? [
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                        'Tidak ada pemancingan yg terdaftar!'),
                                  ),
                                ]
                              : [
                                  for (var pemancingan
                                      in pemancinganSayaContoller
                                          .listPemancinganByUser)
                                    CardByUserWidget(
                                      status: pemancingan.status,
                                      image:
                                          'http://192.168.0.2:8000/api/images-pemancingan/${pemancingan.image}',
                                      title: pemancingan.namaPemancingan,
                                      alamat: pemancingan.alamat,
                                      mulai: pemancingan.buka,
                                      selesai: pemancingan.tutup,
                                      kategori: pemancingan.category,
                                      kecamatan: pemancingan.kecamatan,
                                      kota: pemancingan.kota,
                                      provinsi: pemancingan.provinsi,
                                      id: pemancingan.id,
                                    ),
                                  Obx(() {
                                    if (pemancinganSayaContoller
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
                                    if (pemancinganSayaContoller
                                            .totalDataPemancinganByUser >
                                        pemancinganSayaContoller
                                            .listPemancinganByUser.length) {
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
                                            pemancinganSayaContoller.page++;
                                            pemancinganSayaContoller
                                                .loadingMore.value = false;
                                            pemancinganSayaContoller
                                                .getDataPemancinganByUser(
                                                  pemancinganSayaContoller
                                                      .searchController.text,
                                                  '${pemancinganSayaContoller.page}',
                                                  pemancinganSayaContoller
                                                      .idUser,
                                                  pemancinganSayaContoller
                                                      .paginate
                                                      .toString(),
                                                )
                                                .then((value) =>
                                                    pemancinganSayaContoller
                                                        .loadingMore
                                                        .value = true);
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
                    pemancinganSayaContoller.listPemancinganByUser.clear();
                    pemancinganSayaContoller.page = 1;
                    await pemancinganSayaContoller
                        .getDetailUser()
                        .then((value) {
                      pemancinganSayaContoller
                          .getDataPemancinganByUser(
                            pemancinganSayaContoller.searchController.text,
                            '${pemancinganSayaContoller.page}',
                            pemancinganSayaContoller.idUser,
                            pemancinganSayaContoller.paginate.toString(),
                          )
                          .then((value) =>
                              pemancinganSayaContoller.loading.value = true);
                    });
                  })),
        ),
        onWillPop: () async => await pemancinganSayaContoller.onWillPop());
  }
}
