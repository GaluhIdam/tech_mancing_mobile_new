import 'package:get/get.dart';
import 'package:tech_mancing/app/layout/view/layout.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/acara-saya.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/acara-user.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/detail-acara-user.view.dart';
import 'package:tech_mancing/app/modules/Acara/views/detail-acara-view.dart';
import 'package:tech_mancing/app/modules/Acara/views/daftar-acara.view.dart';
import 'package:tech_mancing/app/modules/Home/views/home.view.dart';
import 'package:tech_mancing/app/modules/Login/views/login.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/daftar-pemacingan.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/detail-pemancingan-for-user.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/detail-pemancingan.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/pemancingan-for-admin.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/pemancingan-saya.view.dart';
import 'package:tech_mancing/app/modules/Pemancingan/views/pemancingan.view.dart';
import 'package:tech_mancing/app/modules/Register/views/register.view.dart';
// import 'package:tech_mancing/app/modules/Home/views/compas.view.dart';
// import '../modules/Home/views/geo.view.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String layout = '/layout';
  static const String home = '/home';

  //Acara Routes
  static const String acara = '/acara';
  static const String acaraUser = '/acara-user';
  static const String daftarAcara = '/daftar-acara';
  static const String detailAcara = '/detail-acara';
  static const String detailAcaraUser = '/detail-acara-user';
  static const String acaraSaya = '/acara-saya';

  //Pemancingan Routes
  static const String pemancingan = '/pemancingan';
  static const String daftarPemancingan = '/daftar-pemancingan';
  static const String detailPemancingan = '/detail-pemancingan';
  static const String detailUserPemancingan = '/detail-pemancingan-user';
  static const String pemancinganSaya = '/pemancingan-saya';
  static const String detailPemancinganAdmin = '/pemancingan-admin';

  static const String geo = '/geo';
  static const String compass = '/compas';
}

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.layout, page: () => LayoutView()),
    GetPage(name: AppRoutes.home, page: () => HomeView()),

    //Acara Routes
    GetPage(name: AppRoutes.acaraSaya, page: () => AcaraSayaView()),
    GetPage(name: AppRoutes.acaraUser, page: () => AcaraUserView()),
    GetPage(name: AppRoutes.daftarAcara, page: () => DaftarAcaraView()),
    GetPage(name: AppRoutes.detailAcara, page: () => AcaraDetailView()),
    GetPage(name: AppRoutes.detailAcaraUser, page: () => DetailAcaraUserView()),

    //Pemancingan Routes
    GetPage(name: AppRoutes.pemancingan, page: () => PemancinganView()),
    GetPage(
        name: AppRoutes.daftarPemancingan, page: () => DaftarPemancinganView()),
    GetPage(
        name: AppRoutes.detailPemancingan, page: () => DetailPemancinganView()),
    GetPage(
        name: AppRoutes.detailUserPemancingan,
        page: () => DetailPemancinganForUserView()),
    GetPage(
        name: AppRoutes.detailPemancinganAdmin,
        page: () => PemancinganForAdmin()),
    GetPage(name: AppRoutes.pemancinganSaya, page: () => PemancinganSayaView()),

    // GetPage(name: AppRoutes.geo, page: () => const GeolocatorWidget()),
    // GetPage(name: AppRoutes.compass, page: () => const CompassView()),
  ];
}
