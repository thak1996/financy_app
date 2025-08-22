import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/widgets/notification.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({
    super.key,
    this.title,
    this.background = true,
    this.iconsButtons = false,
    
  });

  final String? title;
  final bool background;
  final bool iconsButtons;

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.background)
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 287.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.greenGradient,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(500, 30),
                  bottomRight: Radius.elliptical(500, 30),
                ),
              ),
            ),
          ),
        Positioned(
          left: 24.w,
          right: 24.w,
          top: 74.h,
          child: widget.title != null ? headerSec() : headerPri(),
        ),
      ],
    );
  }

  Row headerSec() {
    return Row(
      mainAxisAlignment:
          widget.iconsButtons
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
      children: [
        if (widget.iconsButtons)
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 18.h,
              color: AppColors.white,
            ),
          ),
        Text(
          widget.title ?? '',
          style: AppTextStyles.text18(
            context,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        if (widget.iconsButtons)
          Icon(Icons.more_horiz, size: 24.h, color: AppColors.white),
      ],
    );
  }

  Row headerPri() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good afternoon,',
              style: AppTextStyles.text14(
                context,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            Text(
              'Enjelin Morgeana',
              style: AppTextStyles.text20(
                context,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        NotificationWidget(),
      ],
    );
  }
}
