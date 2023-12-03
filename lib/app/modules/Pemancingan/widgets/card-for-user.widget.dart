import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/controllers/layout.controller.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-detail.controller.dart';

class CardForUserWidget extends StatelessWidget {
  final int id;
  final int? meter;
  final String? image;
  final String title;
  final String alamat;
  final String mulai;
  final String selesai;
  final String kategori;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final double? rate;

  CardForUserWidget({
    Key? key, // Add the key parameter
    required this.id,
    required this.meter,
    required this.image,
    required this.title,
    required this.alamat,
    required this.mulai,
    required this.selesai,
    required this.kategori,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.rate,
  }) : super(key: key); // Call the superclass constructor

  final PemancinganDetailController pemancinganDetailContoller =
      Get.put(PemancinganDetailController());
  final LayoutController layoutController = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10), // Simplify EdgeInsets
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7, top: 10, bottom: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                          width: 1), // Add some space between the icon and text
                      Text(
                        "$meter meter",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                      bottom: 3, top: 0, left: 10, right: 10),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromRGBO(4, 99, 128, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Jam : $mulai WIB - $selesai WIB",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 99, 128, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                      bottom: 5, top: 5, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Alamat : ",
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$alamat.',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        '$kecamatan, $kota, $provinsi.',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                      margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                      decoration: BoxDecoration(
                          color: kategori == 'Keluarga'
                              ? const Color.fromRGBO(4, 99, 128, 1)
                              : const Color.fromARGB(255, 14, 128, 4),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "$kategori",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Rate : ${rate!.toStringAsFixed(1)}",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.star,
                      size: 15.0,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(4, 99, 128, 1),
                      ),
                    ),
                    onPressed: () {
                      pemancinganDetailContoller.getPemancinganById(id);
                    },
                    child: const Text(
                      'Lihat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
