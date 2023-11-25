import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/modules/Login/services/auth.service.dart';
import 'package:tech_mancing/app/routes/routes.dart';
import 'package:tech_mancing/app/widget/controllers/navigation.controller.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final GlobalKey<FormState> formLogin =
      GlobalKey<FormState>(debugLabel: 'formLogin');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());

  DateTime? currentBackPressTime;

  RxBool loading = false.obs;
  RxBool logging = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  // Check Token
  Future<void> checkToken() async {
    await authService.readToken().then((value) {
      if (value['logging'] == true) {
        logging.value = true;
        loading.value = true;
        Get.offNamed(AppRoutes.layout);
      } else {
        logging.value = false;
        loading.value = true;
        Get.offNamed(AppRoutes.login);
      }
    });
  }

  //Login Method
  Future<void> login(context, String email, String password) async {
    if (formLogin.currentState!.validate()) {
      await authService.login(email, password).then((value) {
        if (value.response == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(value.message)));
        } else {
          authService.createToken(value.token!, email);
          passwordController.clear();
          Get.offNamed(AppRoutes.layout);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text(value.message)));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Harap masukan akun anda!")));
    }
  }

  //Logout Method
  Future<void> logout(context) async {
    await authService.logout().then((value) {
      Get.offNamed(AppRoutes.login);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text("Logout Berhasil!")));
    });
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate email format
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> moveRegister() async {
    Get.offNamed(AppRoutes.register);
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Back again to exit");
      return false;
    }
    Get.back();
    return true;
  }
}