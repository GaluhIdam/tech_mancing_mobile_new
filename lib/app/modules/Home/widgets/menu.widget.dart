import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          height: 600,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 25, 5, 5),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Cari Pemancingan",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "e.g pemancingan pamulang"),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 2),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Rekomendasi & Terdekat :",
                            style:
                                TextStyle(color: Color.fromRGBO(4, 99, 128, 1)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread of the shadow
                                offset: const Offset(
                                    0, 1), // Offset from the widget
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(
                                10), // Optional: Apply rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: const Text(
                                    "Lele Mania",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
