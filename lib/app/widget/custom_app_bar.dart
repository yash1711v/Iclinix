import 'package:flutter/material.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:flutter_slide_drawer/flutter_slide_widget.dart';
import '../../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;
  final Widget? drawerButton;
  final Color? bgColor;
  final Color? iconColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.isBackButtonExist = false,
    this.menuWidget,
    this.drawerButton, this.bgColor, this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: openSansBold.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: iconColor??  Theme.of(context).disabledColor,
        ),
      ),
      centerTitle: false,
      leading: isBackButtonExist
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: iconColor??  Theme.of(context).primaryColor,
              onPressed: () => Navigator.pop(context),
            )
          : drawerButton,
      backgroundColor: bgColor??  Theme.of(context).cardColor,
      elevation: 0,
      actions: menuWidget != null
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: menuWidget!,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class CustomMenuButton extends StatelessWidget {
  final Function() tap;

  const CustomMenuButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Image.asset(
          Images.icMenu,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
