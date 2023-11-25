import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/widgets/card.widget.dart';

class PemancinganView extends StatelessWidget {
  PemancinganView({super.key});
  final LayoutController layoutController = Get.put(LayoutController());
  final PemancinganContoller pemancinganContoller =
      Get.put(PemancinganContoller());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: "cari pemancingan terdekat...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "e.g pemancingan pamulang 86"),
            ),
          ),
          Obx(() => Column(
                children: pemancinganContoller.listPemancingan.isEmpty
                    ? [
                        Text('Pemancingan Not Available'),
                      ]
                    : [
                        for (var pemancingan
                            in pemancinganContoller.listPemancingan)
                          CardWidget(
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
                            id: pemancingan.id!,
                          ),
                      ],
              ))
        ]),
      ),
    );
  }
}
