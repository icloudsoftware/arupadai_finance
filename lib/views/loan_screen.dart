import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../theme/app_colors.dart';
import '../widgets/Common_card.dart';
import 'new_loan.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),


      appBar: AppBar(
        leading: Text(""),
        elevation: 0,
        backgroundColor: const Color(0xFF1F3C88),
        centerTitle: true,
        title: Text(
          "Loans",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          IconButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewLoanScreen()));
          }, icon: Icon(Icons.add,color: Colors.white,))
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              // labelPadding: EdgeInsets.symmetric(horizontal: 8.w,),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),

              indicator: BubbleTabIndicator(
                indicatorHeight: 30.h,
                indicatorColor: AppColors.primary,
                indicatorRadius: 16.r,
              ),

              tabs: const [
                Tab(text: "All Loans"),
                Tab(text: "Active"),
                Tab(text: "Closed"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_allLoans(), _activeLoans(), _closedLoans()],
            ),
          ),
        ],
      ),
    );
  }


  Widget _allLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [
        LoanCard(isActive: true, progress: 0.54),
        LoanCard(isActive: false, progress: 0.20),
      ],
    );
  }


  Widget _activeLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [LoanCard(isActive: true, progress: 0.54)],
    );
  }


  Widget _closedLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [LoanCard(isActive: false, progress: 0.20)],
    );
  }
}

class LoanCard extends StatelessWidget {
  final bool isActive;
  final double progress;

  const LoanCard({super.key, required this.isActive, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6.r),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LOAN003",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isActive ? "Active" : "Closed",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            "Anita Kumari",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 8.h),

          Row(
            children: [
              _amountBox("Loan", "₹15,000", Colors.black),
              SizedBox(width: 6.w),
              _amountBox("Balance", "₹7,980", Colors.orange),
            ],
          ),

          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Progress", style: TextStyle(fontSize: 10.sp)),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 3.h,
            percent: progress,
            barRadius: Radius.circular(8.r),
            backgroundColor: Colors.grey.shade200,
            progressColor: Colors.green,
          ),

          SizedBox(height: 8.h),

          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: const [
              InfoChip(icon: Icons.calendar_today, text: "25/4/2024"),
              InfoChip(icon: Icons.percent, text: "12%"),
              InfoChip(icon: Icons.timer, text: "26w"),
              InfoChip(icon: Icons.currency_rupee, text: "₹150"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _amountBox(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: const Color(0xffF6F8FC),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
