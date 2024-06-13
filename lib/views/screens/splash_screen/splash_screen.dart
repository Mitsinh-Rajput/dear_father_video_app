import 'dart:async';
import 'dart:developer';

import 'package:dear_father_video_app/views/base/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../base/custom_image.dart';
import 'form_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool _showFirstImage = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    Timer.run(() async {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {});
      });
      Get.find<AuthController>().controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleImage() {
    if (_showFirstImage) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            PageView.builder(
              controller: authController.pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: authController.images.length,
              onPageChanged: (va) {
                log("${authController.pageController.page}");
                authController.index = va;
                authController.update();
              },
              itemBuilder: (BuildContext context, int index) {
                if (index == 1) {
                  return const FormScreen();
                }
                return CustomImage(
                  path: authController.images[index],
                  width: size.width,
                  height: size.height,
                );
              },
            ),
            if (authController.pageController.hasClients)
              if (authController.pageController.page == 0) const HomePage(),

            // Forward Button
            if (authController.pageController.hasClients)
              if (authController.pageController.page!.round() < 1)
                Positioned(
                  bottom: 220,
                  right: size.width / 2 - 30,
                  child: CustomButton(
                    height: 60,
                    type: ButtonType.primary,
                    color: Colors.blue,
                    onTap: () {
                      authController.forwardButton();
                    },
                    child: Row(
                      children: [Icon(Icons.play_arrow)],
                    ),
                  ),
                ),
          ],
        ),
      ));
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.only(top: size.height * 0.06),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            Assets.images2D,
          ),
        ),
      ),
    );
  }
}
