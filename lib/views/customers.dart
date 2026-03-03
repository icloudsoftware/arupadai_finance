import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../theme/app_colors.dart';
import '../controllers/ui_controller.dart';
import '../models/ui_model.dart';
import 'add_customer.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContectController());

    final customers = [
      ContectModel(
        name: "Lakshmi Devi",
        customerId: "CUST001",
        phone: "8765432100",
        location: "Erode",
        status: "Verified",
      ),
      ContectModel(
        name: "Savitri Bai",
        customerId: "CUST002",
        phone: "8765432101",
        location: "Sitapur",
        status: "Verified",
      ),
      ContectModel(
        name: "Anita Kumari",
        customerId: "CUST003",
        phone: "8765432102",
        location: "Kurnool",
        status: "Pending",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        leading: Text(""),
        backgroundColor: AppColors.primary,
        title: Text(
          "Customers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCustomerView()),
              );
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: SizedBox(
              height: 50.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by name, mobile, or ID",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _filter("All", 0, controller),
                  _filter("Active", 1, controller),
                  _filter("Inactive", 2, controller),
                ],
              ),
            ),
          ),

          /// List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: customers.length,
              itemBuilder: (_, index) {
                return CustomerCard(customer: customers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filter(String text, int index, ContectController c) {
    final bool selected = c.selectedFilter.value == index;
    return GestureDetector(
      onTap: () => c.changeFilter(index),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final ContectModel customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final bool isActive = customer.status == "Verified";

    // Dummy values (replace later with real data)
    final String outstandingAmount = "₹2,500";
    final String paidAmount = "₹7,500";

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Name + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  customer.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp, // MAX 15
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _statusChip(isActive),
            ],
          ),

          SizedBox(height: 6.h),

          /// Customer ID
          Text(
            "ID: ${customer.customerId}",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 6.h),


          /// Financial Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Out: $outstandingAmount",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Paid: $paidAmount",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(bool active) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: active
            ? Colors.green.withOpacity(0.12)
            : Colors.red.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        active ? "Active" : "Inactive",
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: active ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}


