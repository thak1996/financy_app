import 'dart:developer';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => log('Notification tapped'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: AppColors.white.withValues(alpha: 0.06),
        ),
        child: Stack(
          alignment: AlignmentDirectional(0.5, -0.5),
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 32.h,
              color: AppColors.white,
            ),
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.notification,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
