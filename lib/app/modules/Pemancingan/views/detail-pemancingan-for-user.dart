import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-detail.controller.dart';

class DetailPemancinganForUserView extends StatelessWidget {
  DetailPemancinganForUserView({super.key});

  final PemancinganDetailController pemancinganDetailController =
      Get.put(PemancinganDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            SizedBox(
              width: double
                  .infinity, // Set the width to the maximum available width
              height: 200.0, // Set the desired height
              child: Image.network(
                pemancinganDetailController.urlImage.value, // Your image URL
                fit:
                    BoxFit.cover, // Crop the image to cover the available space
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 15,
                  ),
                  Text(
                    pemancinganDetailController.selectedProvinsi.value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                pemancinganDetailController.namaController.value,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(4, 99, 128, 1)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                pemancinganDetailController.alamatController.value,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                '${pemancinganDetailController.selectedKecamatan.value}, ${pemancinganDetailController.selectedKota.value}',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Text(
                pemancinganDetailController.descriptionController.value,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                'Kategori : ${pemancinganDetailController.selectedKategori.value}',
                style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(4, 99, 128, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Text(
                'Buka : ${pemancinganDetailController.bukaController.value} - ${pemancinganDetailController.tutupController.value} WIB',
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Row(
                  children: [
                    Text(
                      "Rate : ${pemancinganDetailController.calculateAverageRating(pemancinganDetailController.komentarPemancingan)}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.star,
                      size: 15.0,
                      color: Colors.amber,
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 15),
              child: Text('data'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Divider(
                thickness: 0.5,
                color: Colors.black,
                indent: 16.0,
                endIndent: 16.0,
              ),
            ),
            Obx(() {
              if (pemancinganDetailController.loading.value == true) {
                return const Center(child: CircularProgressIndicator());
              } else {
                bool hasUser = pemancinganDetailController.komentarPemancingan
                    .any((element) =>
                        element.idUser ==
                        pemancinganDetailController.idUserCheck.value);
                if (hasUser == false) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: const Center(
                          child: Text(
                            'Rate :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          child: RatingBar.builder(
                            itemSize: 27.0,
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              pemancinganDetailController.rate.value =
                                  rating.toInt();
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: TextField(
                          controller: pemancinganDetailController.komentar,
                          minLines: 5,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Ketik komentar...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            pemancinganDetailController.postKomentar(context);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(4, 99, 128, 1))),
                          child: const Text('Kirim'),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const Center(
                        child: Text(
                          'Komentar Mu :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: pemancinganDetailController
                            .komentarPemancingan
                            .map(
                              (data) => data.idUser ==
                                      pemancinganDetailController
                                          .idUserCheck.value
                                  ? Card(
                                      color: const Color.fromARGB(
                                          255, 183, 209, 254),
                                      elevation: 3.0,
                                      margin: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(
                                                DateFormat('EEEE, d MMMM y')
                                                    .format(DateTime.parse(data
                                                            .createdAt
                                                            .toString())
                                                        .toLocal()),
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data.userKomentar.name,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  pemancinganDetailController
                                                      .buildStarRating(
                                                          data.rate),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                data.komentar,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }
              }
            }),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Divider(
                thickness: 0.5,
                color: Colors.black,
                indent: 16.0,
                endIndent: 16.0,
              ),
            ),
            Obx(() {
              if (pemancinganDetailController.loading.value == true) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            'Daftar Komentar :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: pemancinganDetailController
                              .komentarPemancingan
                              .map(
                                (data) => Card(
                                  elevation: 3.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text(
                                            DateFormat('EEEE, d MMMM y').format(
                                                DateTime.parse(data.createdAt
                                                        .toString())
                                                    .toLocal()),
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.userKomentar.name,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              pemancinganDetailController
                                                  .buildStarRating(data.rate),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            data.komentar,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ));
              }
            })
          ],
        ),
      ),
      onWillPop: () async =>
          await pemancinganDetailController.backToPemancingan(),
    );
  }
}
