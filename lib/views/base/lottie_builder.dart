// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../services/extensions.dart';
//
// class CustomLottie extends StatefulWidget {
//   const CustomLottie({
//     Key? key,
//     this.networkLottie,
//     this.assetLottie,
//     this.animate = true,
//     this.repeat = true,
//     this.width,
//     this.height,
//     this.fit,
//   })  : assert(networkLottie != null || assetLottie != null, "Network Or Asset Url is required"),
//         super(key: key);
//
//   final String? networkLottie;
//   final String? assetLottie;
//   final bool animate;
//   final bool repeat;
//   final double? width;
//   final double? height;
//   final BoxFit? fit;
//
//   @override
//   State<CustomLottie> createState() => _CustomLottieState();
// }
//
// class _CustomLottieState extends State<CustomLottie> with SingleTickerProviderStateMixin {
//   late AnimationController lottieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     lottieController = AnimationController(
//       vsync: this,
//     );
//
//     lottieController.addStatusListener((status) async {
//       if (status == AnimationStatus.completed) {
//         if (widget.repeat) {
//           lottieController.repeat();
//         } else {
//           // lottieController.reset();
//         }
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     lottieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.assetLottie.isValid) {
//       return Lottie.asset(
//         widget.assetLottie!,
//         repeat: widget.repeat,
//         height: widget.height,
//         width: widget.width,
//         animate: widget.animate,
//         fit: widget.fit,
//         controller: lottieController,
//         onLoaded: (composition) {
//           lottieController.duration = composition.duration;
//           lottieController.forward();
//         },
//       );
//     } else {
//       return Lottie.network(
//         widget.networkLottie!,
//         repeat: widget.repeat,
//         height: widget.height,
//         width: widget.width,
//         animate: widget.animate,
//         fit: widget.fit,
//         controller: lottieController,
//         onLoaded: (composition) {
//           lottieController.duration = composition.duration;
//           lottieController.forward();
//         },
//       );
//     }
//   }
// }
