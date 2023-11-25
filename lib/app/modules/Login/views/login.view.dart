import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Login/controllers/login.controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
          child: Scaffold(
              backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
              body: Obx(() {
                if (controller.loading.value == false) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          alignment: Alignment.center,
                          height: 250,
                          child: Image.asset("assets/logo-bg.png"),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Form(
                            key: controller.formLogin,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller:
                                              controller.emailController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            if (!controller
                                                .isValidEmail(value)) {
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            0, 10, 0, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    4, 99, 128, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            controller.login(
                                                context,
                                                controller.emailController.text,
                                                controller
                                                    .passwordController.text);
                                          },
                                          child: const Center(
                                            child: Text(
                                              "Masuk",
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
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Center(
                              child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Jika anda belum miliki akun, ",
                              style: const TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "daftar disini.",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      controller.moveRegister();
                                    },
                                ),
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  );
                }
              })),
          onWillPop: () async => await controller.onWillPop()),
    );
  }
}
