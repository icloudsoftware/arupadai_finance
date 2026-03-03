import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imayam/views/record_collection.dart';

import '../controllers/ui_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'incentivesScreen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// 🟦 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.goodDay,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
            Text(
              AppTexts.agentDashboard,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _statCard(
                title: "Total Collection",
                value: "₹1500",
                icon: Icons.currency_rupee_outlined,
                gradientColors: const [
                  Color(0xFF43CEA2),
                  Color(0xFF185A9D),
                ],
                onTap: () {
                  Get.find<BottomNavController>().changeIndex(1);
                },
              ),
              _statCard(
                title: "Today Collection",
                value: "Cash & bank",
                icon: Icons.currency_rupee_outlined,
                gradientColors: const [
                  Color(0xFFFF6B6B),
                  Color(0xFF556270),
                ],
                onTap: () {
                  Get.find<BottomNavController>().changeIndex(1);
                },
              ),
              _statCard(
                title: "Pending Dues",
                value: "3",
                icon: Icons.pending_actions,
                gradientColors:  [
                  Color(0xFFFFB36A),
                  Color(0xFFFF8F3D),
                ],
                onTap: () {
                  Get.find<BottomNavController>().changeIndex(1);
                },
              ),
              _statCard(
                title: "Today Due",
                value: "Daily/Weekly/monthly",
                icon: Icons.currency_rupee_outlined,
                gradientColors: const [
                  Color(0xFF6A82FB),
                  Color(0xFFFC5C7D),
                ],
                onTap: () {
                  Get.find<BottomNavController>().changeIndex(1);
                },
              ),
              _statCard(
                title: "Pending Amount",
                value: "1000",
                icon: Icons.currency_rupee_outlined,
                gradientColors:  [
                  Color(0xFF60A5FA),
                  Color(0xFF1E3A8A),
                ],
                onTap: () {
                  Get.find<BottomNavController>().changeIndex(1);
                },
              ),
              SizedBox(height: 24.h),


              Text(
                AppTexts.quickActions,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: _quickActionCard(
                      title: "Receipt",
                      icon: Icons.receipt_long,
                      color: AppColors.green,
                      onTap: () {
                        Get.find<BottomNavController>().changeIndex(1);
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: _quickActionCard(
                  //     title: "New Loan",
                  //     icon: Icons.account_balance,
                  //     color: AppColors.orange,
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => NewLoanScreen(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: _quickActionCard(
                      title: "Collection",
                      icon: Icons.payments,
                      color: AppColors.blue,
                      onTap: () {
                        Get.find<BottomNavController>().changeIndex(2);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  /// 🌈 STAT CARD
  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12.sp,

                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  /// ⚡ QUICK ACTION CARD (ICON TOP CENTER)
  Widget _quickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 130.w,
        height: 120.h,
        // margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32.sp),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
