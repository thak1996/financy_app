import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/widgets/alert_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.controller.dart';
import 'home.state.dart';
import 'dart:developer';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        final controller = context.read<HomeController>();
        return BlocListener<HomeController, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              AlertDialogWidget.show(
                context,
                title: 'Erro',
                message: state.message,
              );
            }
          },
          child: _buildBody(controller, context),
        );
      },
    );
  }

  Widget _buildBody(HomeController controller, BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 380.h,
            child: Stack(
              children: [
                backgroundTophome(),
                headerHome(context),
                cardHeader(context),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r, vertical: 4.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions History',
                        style: AppTextStyles.text18(
                          context,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'See all',
                        style: AppTextStyles.text14(
                          context,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final color =
                            index % 2 == 0
                                ? AppColors.income
                                : AppColors.outcome;
                        final value =
                            index % 2 == 0 ? "+ \$ 100.00" : "- \$ 100.00";
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.r),
                          leading: Container(
                            decoration: BoxDecoration(
                              color: AppColors.antiFlashWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.r),
                              ),
                            ),
                            padding: EdgeInsets.all(8.r),
                            child: Icon(Icons.monetization_on_outlined),
                          ),
                          title: Text(
                            'UpWork',
                            style: AppTextStyles.text16(
                              context,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Today',
                            style: AppTextStyles.text14(
                              context,
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Text(
                            value,
                            style: AppTextStyles.text16(
                              context,
                              color: color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned cardHeader(BuildContext context) {
    return Positioned(
      left: 24.w,
      right: 24.w,
      top: 155.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColors.darkGreen,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 18.r,
              spreadRadius: 0,
              offset: Offset(0, 16.r),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: AppTextStyles.text16(
                        context,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      'R\$ 1,556.00',
                      style: AppTextStyles.text24(
                        context,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => log('options'),
                  child: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.more_horiz, color: AppColors.white),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(child: Text('Option 1')),
                          PopupMenuItem(child: Text('Option 2')),
                        ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Icon(
                        Icons.arrow_downward,
                        color: AppColors.white,
                        size: 18.h,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: AppTextStyles.text16(
                            context,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '\$ 1,840.00',
                          style: AppTextStyles.text20(
                            context,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        color: AppColors.white,
                        size: 18.h,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expenses',
                          style: AppTextStyles.text16(
                            context,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '\$ 284.00',
                          style: AppTextStyles.text20(
                            context,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned headerHome(BuildContext context) {
    return Positioned(
      left: 24.w,
      right: 24.w,
      top: 74.h,
      child: Row(
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
          GestureDetector(
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
          ),
        ],
      ),
    );
  }

  Positioned backgroundTophome() {
    return Positioned(
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
    );
  }
}
