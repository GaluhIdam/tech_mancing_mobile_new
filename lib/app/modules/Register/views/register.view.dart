import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Register/controllers/register.controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final RegisterController controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
            child: Scaffold(
                backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        alignment: Alignment.center,
                        height: 150,
                        child: Image.asset("assets/logo-bg.png"),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: const Center(
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Form(
                          key: controller.formRegister,
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        controller: controller.namaController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "Nama Lengkap",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            hintText: "e.g Sendy Pramuka"),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controller.noController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your phone number';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "Nomor Handphone",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            hintText: "e.g 081234567890"),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: controller.emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          if (!controller.isValidEmail(value)) {
                                            return 'Please enter a valid email address.';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "Email",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            hintText: "e.g user@gmail.com"),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextFormField(
                                        controller:
                                            controller.passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelText: "Password",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: "********",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextFormField(
                                        controller:
                                            controller.repasswordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your re-password';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelText: "Re-Password",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: "********",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              4, 99, 128, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.register(context);
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Daftar",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 7, 197, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async =>
                                            await controller.onWillPop(),
                                        child: const Center(
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  side: const BorderSide(color: Colors.white),
                                  value: controller.isChecked.value,
                                  onChanged: (value) =>
                                      controller.isChecked.toggle(),
                                ),
                              ),
                              Expanded(
                                  child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Saya menyetujui, ",
                                  style: const TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: "syarat dan ketentuan.",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          )),
                    ],
                  ),
                )),
            onWillPop: () async => await controller.onWillPop()));
  }
}
