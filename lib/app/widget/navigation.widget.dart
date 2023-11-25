import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_mancing/app/routes/routes.dart';
import 'controllers/navigation.controller.dart';

// ignore: must_be_immutable
class NavigationWidget extends StatelessWidget {
  final PageController pageController = Get.put(PageController());
  BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: Get.find<PageController>(),
          children: AppPages.pages.map((page) => page.page()).toList(),
          onPageChanged: (index) {
            controller.currentIndex.value = index;
          },
        ),
        bottomNavigationBar: Obx(() => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.red,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: controller.currentIndex.value,
                onTap: (index) {
                  pageController.jumpToPage(index);
                  controller.currentIndex.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.explore), label: 'Explore'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            )));
  }
}
