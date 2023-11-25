import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_mancing/app/modules/Acara/controllers/acara.controller.dart';

class EventWidget extends StatelessWidget {
  final int idAcara;
  final String? image;
  final String title;
  final String description;
  final String pemancingan;
  final DateTime mulai;
  final DateTime selesai;
  final int? status;
  final int grandPrize;
  EventWidget(
      {super.key,
      required this.idAcara,
      required this.image,
      required this.title,
      required this.description,
      required this.pemancingan,
      required this.mulai,
      required this.selesai,
      required this.status,
      required this.grandPrize});

  final AcaraController acaraController = Get.put(AcaraController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            blurRadius: 3, // Spread of the shadow
            offset: const Offset(0, 1), // Offset from the widget
          ),
        ],
        color: Colors.white, // Background color
        borderRadius:
            BorderRadius.circular(10), // Optional: Apply rounded corners
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
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                    '${DateFormat('d MMMM yyyy').format(mulai)} - ${DateFormat('d MMMM yyyy').format(selesai)}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromRGBO(4, 99, 128, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Lokasi : ' + pemancingan,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Total Hadiah : Rp.${NumberFormat('#,###').format(grandPrize)}",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(4, 99, 128, 1))),
                      onPressed: () {
                        acaraController.getAcaraById(idAcara);
                      },
                      child: const Text(
                        'Lihat',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
