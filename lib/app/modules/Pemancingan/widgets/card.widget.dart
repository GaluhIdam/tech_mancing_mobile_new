import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan.controller.dart';

class CardWidget extends StatelessWidget {
  final int id;
  final int? status;
  final String? image;
  final String title;
  final String alamat;
  final String mulai;
  final String selesai;
  final String kategori;
  final String kecamatan;
  final String kota;
  final String provinsi;

  CardWidget({
    Key? key, // Add the key parameter
    required this.id,
    required this.status,
    required this.image,
    required this.title,
    required this.alamat,
    required this.mulai,
    required this.selesai,
    required this.kategori,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
  }) : super(key: key); // Call the superclass constructor

  final PemancinganContoller pemancinganContoller =
      Get.put(PemancinganContoller());

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
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 7),
                  decoration: BoxDecoration(
                    color: status == null
                        ? const Color.fromRGBO(215, 223, 0, 1)
                        : status == true
                            ? const Color.fromRGBO(3, 165, 0, 1)
                            : const Color.fromRGBO(177, 0, 0, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    status == null
                        ? "Menunggu Persetujuan"
                        : status == 1
                            ? "Disetujui"
                            : "Ditolak",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 5),
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
                    const Text(
                      "Rate : 4.5",
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
                      pemancinganContoller.getPemancinganById(id);
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
