import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../services/input_decoration.dart';
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
              physics: ((authController.index ?? 0) < 2) ? const NeverScrollableScrollPhysics() : const ScrollPhysics(),
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
                if (index == 4) {
                  return Stack(
                    children: [
                      CustomImage(
                        path: authController.images[index],
                        width: size.width,
                        height: size.height,
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   left: (size.width / 2)-200,
                      //   child: CustomImage(
                      //     path: Assets.pngs11,
                      //     height: 400,
                      //   ),
                      // ),
                      Positioned(
                        top: 270,
                        left: 172,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs1,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs14,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 220,
                        left: 350,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs2,
                                        height: 190,
                                        width: 190,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs15,
                                              height: 190,
                                              width: 190,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        right: 330,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs3,
                                        height: 190,
                                        width: 190,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs16,
                                              height: 190,
                                              width: 190,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 275,
                        right: 146,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs4,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs17,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 415,
                        right: 270,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs8,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs18,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 137,
                        left: 132,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs5,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs18,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 191,
                        left: 297,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs6,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs19,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 337,
                        left: 451,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs7,
                                        height: 200,
                                        width: 200,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs20,
                                              height: 200,
                                              width: 200,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 35,
                        right: 291,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs10,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs23,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 135,
                        right: 130,
                        child: GestureDetector(
                          onTap: _toggleImage,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * 3.14159;
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle - 270.0),
                                child: _animation.value <= 0.5
                                    ? CustomImage(
                                        path: Assets.pngs9,
                                        height: 180,
                                        width: 180,
                                      )
                                    : Transform.flip(
                                        flipX: true,
                                        child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity(),
                                            child: CustomImage(
                                              path: Assets.pngs22,
                                              height: 180,
                                              width: 180,
                                            )),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
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
            if (authController.pageController.hasClients)
              if (authController.pageController.page?.round() == authController.images.length - 1) const Comments(),

            // Sync Button
            if (authController.pageController.hasClients)
              if (authController.pageController.page?.round() == 0)
                Positioned(
                  bottom: 20,
                  left: 45,
                  child: GestureDetector(
                    onTap: () async {
                      // await authController.submitForm();
                      authController.controller.forward(from: 0).then((value) async {
                        await authController.syncData();
                      });
                    },
                    child: AnimatedBuilder(
                        animation: authController.controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: authController.controller.value * 2 * 3.14159265359,
                            child: const CustomImage(
                              path: Assets.imagesSyncBlue,
                              height: 60,
                              width: 60,
                            ),
                          );
                        }),
                  ),
                ),

            // Forward Button
            if (authController.pageController.hasClients)
              if (authController.pageController.page!.round() < 2)
                Positioned(
                  bottom: 20,
                  right: 45,
                  child: GestureDetector(
                    onTap: () async {
                      authController.forwardButton();
                    },
                    child: const CustomImage(
                      path: Assets.imagesForwardBlue,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
            // Home Button
            if (authController.pageController.hasClients)
              if (authController.pageController.page!.round() > 0)
                Positioned(
                  bottom: 20,
                  left: 45,
                  child: GestureDetector(
                    onTap: () async {
                      authController.resetForm();
                    },
                    child: const CustomImage(
                      path: Assets.imagesB4,
                      height: 60,
                      width: 60,
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

class QuestionOne extends StatefulWidget {
  const QuestionOne({Key? key}) : super(key: key);

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.imagesBG,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const Text(
                    "1",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
                  ),
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "On an average how many patients\nwith lower uretric stone do you\ncome across/month",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 50, color: const Color(0xFF336666), height: 0, fontFamily: 'JosefinSans-Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              padding: EdgeInsets.only(left: size.width * 0.30),
              shrinkWrap: true,
              itemCount: authController.QuestionOneOption.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      authController.QuestionOneAnswer = authController.QuestionOneOption[index];
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(
                        value: authController.QuestionOneOption[index],
                        groupValue: authController.QuestionOneAnswer,
                        onChanged: (String? value) {
                          setState(() {
                            authController.QuestionOneAnswer = value!;
                          });
                        },
                        activeColor: const Color(0xFF336666),
                      ),
                      Text(
                        authController.QuestionOneOption[index],
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 40),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

class QuestionTwo extends StatefulWidget {
  const QuestionTwo({Key? key}) : super(key: key);

  @override
  State<QuestionTwo> createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                Assets.imagesBG,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const Text(
                    "2",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
                  ),
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Of the lower ureteric stone patients\nseen per month what would be the approx.\n% of patients with stone size <8mm",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF336666),
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: authController.QuestionSecondAnswer,
                    maxLines: 12,
                    decoration: CustomDecoration.inputDecoration(borderColor: Colors.black38),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class QuestionThree extends StatefulWidget {
  const QuestionThree({Key? key}) : super(key: key);

  @override
  State<QuestionThree> createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {
  // bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.imagesBG,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const Text(
                "3",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
              ),
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const SizedBox(height: 15),
              Text(
                "In your clinical practice what is the\nfirst line of medical therapy for patients\nwith lower ureteric stones <8mm",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 50, color: const Color(0xFF336666), fontWeight: FontWeight.bold, fontFamily: 'JosefinSans-Bold', height: 0),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: size.width * 0.30),
                shrinkWrap: true,
                itemCount: authController.QuestionThirdOption.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            authController.QuestionThirdAnswer = authController.QuestionThirdOption[index];
                            authController.update();
                          });
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: authController.QuestionThirdOption[index],
                              groupValue: authController.QuestionThirdAnswer,
                              onChanged: (String? value) {
                                setState(() {
                                  authController.QuestionThirdAnswer = value!;
                                  authController.update();
                                });
                              },
                              activeColor: const Color(0xFF336666),
                            ),
                            Text(
                              authController.QuestionThirdOption[index],
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 40),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              if (authController.QuestionThirdAnswer == "Others (Pls specify)")
                Container(
                  width: 400,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextField(
                    controller: authController.QuestionThirdAnswerForOther,
                    autofocus: true,
                  ),
                )
            ],
          ),
        ),
      );
    });
  }
}

class QuestionFour extends StatefulWidget {
  const QuestionFour({Key? key}) : super(key: key);

  @override
  State<QuestionFour> createState() => _QuestionFourState();
}

class _QuestionFourState extends State<QuestionFour> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.imagesBG,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const Text(
                "4",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
              ),
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const SizedBox(height: 15),
              Text(
                "Have you used the combination of\nTamsulosin + Deflazacort in your\nclinical practice",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 50, color: const Color(0xFF336666), fontWeight: FontWeight.bold, fontFamily: 'JosefinSans-Bold', height: 0),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: size.width * 0.30),
                shrinkWrap: true,
                itemCount: authController.QuestionFourthOption.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        authController.QuestionfourthAnswer = authController.QuestionFourthOption[index];
                        authController.update();
                      });
                    },
                    child: Row(
                      children: [
                        Radio<String>(
                          value: authController.QuestionFourthOption[index],
                          groupValue: authController.QuestionfourthAnswer,
                          onChanged: (String? value) {
                            setState(() {
                              authController.QuestionfourthAnswer = value!;
                              authController.update();
                            });
                          },
                          activeColor: const Color(0xFF336666),
                        ),
                        Text(
                          authController.QuestionFourthOption[index],
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 40),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionFive extends StatefulWidget {
  const QuestionFive({Key? key}) : super(key: key);

  @override
  State<QuestionFive> createState() => _QuestionFiveState();
}

class _QuestionFiveState extends State<QuestionFive> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.imagesBG,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const Text(
                "5",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
              ),
              Container(
                height: 1,
                width: 40,
                color: const Color(0xFF91c256),
              ),
              const SizedBox(height: 15),
              Text(
                "If yes, how would you rate the\ncombination on the scale of 1-5\n(1-Lowest, 5-Highest) on the basis of",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 50, color: const Color(0xFF336666), fontWeight: FontWeight.bold, fontFamily: 'JosefinSans-Bold', height: 0),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: size.width * 0.30),
                shrinkWrap: true,
                itemCount: authController.QuestionFifthOption.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 350,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                authController.QuestionFifthOption[index],
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 40),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: 132,
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    "Select a value",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  dropdownColor: Colors.white,
                                  value: authController.QuestionfifthValues[index],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      authController.QuestionfifthValues[index] = newValue;
                                    });
                                  },
                                  items: <String>['1', '2', '3', '4', '5'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionSix extends StatefulWidget {
  const QuestionSix({super.key});

  @override
  State<QuestionSix> createState() => _QuestionSixState();
}

class _QuestionSixState extends State<QuestionSix> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.imagesBG,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const Text(
                    "6",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
                  ),
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "What is the average Rx duration\nof the combination in your\nclinical practice",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 50, color: const Color(0xFF336666), height: 0, fontFamily: 'JosefinSans-Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              padding: EdgeInsets.only(left: size.width * 0.30),
              shrinkWrap: true,
              itemCount: authController.QuestionSixOption.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      authController.QuestionSixAnswer = authController.QuestionSixOption[index];
                      authController.update();
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(
                        value: authController.QuestionSixOption[index],
                        groupValue: authController.QuestionSixAnswer,
                        onChanged: (String? value) {
                          setState(() {
                            authController.QuestionSixAnswer = value!;
                          });
                        },
                        activeColor: const Color(0xFF336666),
                      ),
                      Text(
                        authController.QuestionSixOption[index],
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 40),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

class QuestionSeven extends StatefulWidget {
  const QuestionSeven({Key? key}) : super(key: key);

  @override
  State<QuestionSeven> createState() => _QuestionSevenState();
}

class _QuestionSevenState extends State<QuestionSeven> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                Assets.imagesBG,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const Text(
                    "7",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF336666)),
                  ),
                  Container(
                    height: 1,
                    width: 40,
                    color: const Color(0xFF91c256),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "If the combination of Tamsulosin +\nDeflazacort is still not used, any specific\nreason for not using the combination in\nyour clinical practice?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 40,
                          height: 0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF336666),
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: authController.QuestionSevenAnswer,
                    maxLines: 10,
                    decoration: CustomDecoration.inputDecoration(borderColor: Colors.black38),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                Assets.imagesBG,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomImage(
                    path: Assets.imagesDADlogo,
                    height: 270,
                    width: 250,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: authController.comments,
                  maxLines: 13,
                  decoration: CustomDecoration.inputDecoration(borderRadius: 20, borderColor: Colors.black38),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      authController.forwardButton();
                    },
                    child: const CustomImage(
                      path: Assets.imagesB3,
                      height: 100,
                      width: 150,
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
