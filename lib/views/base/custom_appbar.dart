import 'package:flutter/material.dart';

import 'custom_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.color,
      this.isHome = false,
      this.centerTitle = false})
      : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? color;
  final bool isHome;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      leading: Navigator.canPop(context)
          ? Builder(builder: (context) {
              if (Navigator.canPop(context)) {
                if (leading != null) {
                  return leading!;
                }
                return BackButton(
                  color: color ?? Theme.of(context).primaryColor,
                );
              }
              return const SizedBox.shrink();
            })
          : null,
      title: Builder(builder: (context) {
        if (isHome) {
          return const CustomImage(
            height: 35,
            path: Assets.imagesLOGO,
          );
        } else {
          if (title != null) {
            return Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 18.0),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      }),
      actions: actions,
    );
  }
}
