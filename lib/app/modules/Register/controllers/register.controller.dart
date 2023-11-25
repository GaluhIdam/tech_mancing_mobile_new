import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Register/services/register.service.dart';
import 'package:tech_mancing/app/routes/routes.dart';

class RegisterController extends GetxController {
  final ResgiterService registerService = Get.put(ResgiterService());
  final GlobalKey<FormState> formRegister =
      GlobalKey<FormState>(debugLabel: 'formRegister');
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  DateTime? currentBackPressTime;
  RxBool isChecked = false.obs;

  //Login Method
  Future<void> register(context) async {
    if (formRegister.currentState!.validate()) {
      if (isChecked.isTrue) {
        String name = namaController.text;
        String email = emailController.text;
        String password = passwordController.text;
        String re_password = repasswordController.text;
        String no_telp = noController.text;
        await registerService
            .registerUser(name, email, password, re_password, no_telp)
            .then((value) {
          if (value.message == 'User has Created Successfully!') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Pendaftaran Berhasil")));
            Get.offNamed(AppRoutes.login);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(value.message)));
            if (value.errors.name.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(value.errors.name[0])));
            }
            if (value.errors.email.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(value.errors.email[0])));
            }
            if (value.errors.noTelp.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(value.errors.noTelp[0])));
            }
            if (value.errors.rePassword.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(value.errors.rePassword[0])));
            }
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Checklist dulu syarat dan ketentuannya!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Pendaftaran Gagal")));
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  Future<bool> onWillPop() async {
    Get.offNamed(AppRoutes.login);
    return true;
  }
}
