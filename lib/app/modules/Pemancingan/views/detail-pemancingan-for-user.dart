import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Pemancingan/controllers/pemancingan-user.controller.dart';

class DetailPemancinganForUserView extends StatelessWidget {
  DetailPemancinganForUserView({super.key});

  final PemancinganUserController pemancinganUserController =
      Get.put(PemancinganUserController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        child: ListView(
          children: [
            SizedBox(
              width: double
                  .infinity, // Set the width to the maximum available width
              height: 200.0, // Set the desired height
              child: Image.network(
                'https://platinumlist.net/guide/wp-content/uploads/2023/03/IMG-worlds-of-adventure.webp', // Your image URL
                fit:
                    BoxFit.cover, // Crop the image to cover the available space
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 15,
                  ),
                  Text(
                    'Banten',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Pemancingan Sendy Lele Mania',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(4, 99, 128, 1)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Jl. Villa Pamulang, Komplek Harmoni Blok G2 No.28, RT.002 RW.012',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Pamulang, Kota Tangerang Selatan',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a,',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                'Kategori : Keluarga',
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(4, 99, 128, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Text(
                'Buka : 12.00 - 23.00 WIB',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Row(
                  children: [
                    Text(
                      "Rate : 5.0",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.star,
                      size: 15.0,
                      color: Colors.amber,
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
              child: TextField(
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'beri komentar...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Kirim'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(4, 99, 128, 1))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'irvan',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'irvan',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'irvan',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.amber,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: () async => await pemancinganUserController.onWillPop(),
    );
  }
}
