import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../theme/app_colors.dart';
import '../widgets/bill_generater.dart';

class RecordCollectionView extends StatefulWidget {
  const RecordCollectionView({super.key});

  @override
  State<RecordCollectionView> createState() => _RecordCollectionViewState();
}

class _RecordCollectionViewState extends State<RecordCollectionView> {
  String selectedLoanType = "Daily";
  int selectedGroup = 0;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  List<String> loanTypes = ["Daily", "Weekly", "Monthly"];

  List<GroupModel> groups = [
    GroupModel(
      groupName: "Group A",
      loans: [
        LoanModel(
          name: "Lakshmi Devi",
          loanId: "LOAN001",
          loanType: "Daily",
          due: 220,
          outstanding: 5280,
        ),
        LoanModel(
          name: "Lakshmi Devi",
          loanId: "LOAN001",
          loanType: "Daily",
          due: 220,
          outstanding: 5280,
        ),
        LoanModel(
          name: "Lakshmi Devi",
          loanId: "LOAN001",
          loanType: "Daily",
          due: 220,
          outstanding: 5280,
        ),
        LoanModel(
          name: "Lakshmi Devi",
          loanId: "LOAN001",
          loanType: "Daily",
          due: 220,
          outstanding: 5280,
        ),
        LoanModel(
          name: "Lakshmi Devi",
          loanId: "LOAN001",
          loanType: "Daily",
          due: 220,
          outstanding: 5280,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Weekly",
          due: 500,
          outstanding: 10000,
        ),
        LoanModel(
          name: "Savitri Bai",
          loanId: "LOAN002",
          loanType: "Monthly",
          due: 500,
          outstanding: 10000,
        ),

      ],
    ),
    GroupModel(
      groupName: "Group B",
      loans: [
        LoanModel(
          name: "Anita Kumari",
          loanId: "LOAN003",
          loanType: "Monthly",
          due: 2000,
          outstanding: 8000,
        ),
      ],
    ),
  ];

  /// Show only unpaid loans of selected type
  List<LoanModel> get loans => groups[selectedGroup].loans
      .where(
        (loan) =>
            loan.loanType == selectedLoanType &&
            loan.isPaid == false &&
            (loan.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                loan.loanId.toLowerCase().contains(searchQuery.toLowerCase())),
      )
      .toList();

  /// Total collected
  double get totalCollected => groups
      .expand((g) => g.loans)
      .where((loan) => loan.loanType == selectedLoanType && loan.isPaid)
      .fold(0.0, (sum, loan) => sum + loan.paidAmount);

  int get totalDueCount => groups[selectedGroup]
      .loans
      .where((loan) =>
  loan.loanType == selectedLoanType &&
      loan.isPaid == false)
      .length;

  double get totalOutstanding => groups[selectedGroup]
      .loans
      .where((loan) =>
  loan.loanType == selectedLoanType &&
      loan.isPaid == false)
      .fold(0.0, (sum, loan) => sum + loan.outstanding);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,

        appBar: AppBar(
          leading: Text(""),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F3C88), Color(0xFF4A6CF7)],
              ),
            ),
          ),
          title: const Text(
            "Record Collection",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// SEARCH BAR
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search by name or Loan ID",
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                                searchQuery = "";
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [

                    /// LEFT – TOTAL DUE COUNT
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            totalDueCount.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          const Text(
                            "Total Due Members",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    /// DIVIDER
                    Container(
                      height: 40.h,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),

                    /// RIGHT – TOTAL OUTSTANDING
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "₹${totalOutstanding.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          const Text(
                            "Total Outstanding",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              /// LOAN TYPE DROPDOWN
              Text(
                "Select Loan Type",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLoanType,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    isExpanded: true,
                    items: loanTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedLoanType = val!;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// MEMBER CARDS
              if (loans.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: const Text("No unpaid members"),
                  ),
                )
              else
                ...loans.map((loan) => _loanCard(loan)).toList(),

              SizedBox(height: 20.h),

              /// TOTAL
              Container(
                margin: EdgeInsets.all(8.w),
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [

                    /// LEFT SIDE (ICON + TITLE)
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Total Collected",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// RIGHT SIDE (AMOUNT)
                    Text(
                      "₹${totalCollected.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        /// RECORD BUTTON
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: () async {
                final paidLoans = groups[selectedGroup].loans
                    .where(
                      (loan) =>
                          loan.loanType == selectedLoanType && loan.isPaid,
                    )
                    .toList();

                if (paidLoans.isEmpty) {
                  toastification.show(
                    context: context, // optional if you use ToastificationWrapper
                    title: Text('Error", "No payments recorded'),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                  return;
                }

                for (var loan in paidLoans) {
                  await CollectionBillGenerator.generate(
                    customer: loan.name,
                    loanId: loan.loanId,
                    group: groups[selectedGroup].groupName,
                    collected: loan.paidAmount,
                    total: loan.paidAmount,
                    paymentMode: loan.paymentMode,
                    remarks: "",
                  );
                }
                toastification.show(
                  context: context,
                  title: Text("Success Collection Recorded"),
                  autoCloseDuration: const Duration(seconds: 5),
                );
                setState(() {});
              },
              child: const Text("Record",style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }

  final List<String> paymentModes = ["Cash", "UPI", "Bank"];

  /// MEMBER CARD DESIGN
  Widget _loanCard(LoanModel loan) {
    final TextEditingController controller =
    TextEditingController(text: loan.due.toString());

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// NAME + OUTSTANDING ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  loan.name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "₹${loan.outstanding}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            "Loan ID: ${loan.loanId}",
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 8.h),

          /// DUE TEXT SMALL
          Text(
            "Due: ₹${loan.due}",
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8.h),

          /// AMOUNT FIELD
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 12.sp),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              hintText: "Collected Amount",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onChanged: (val) {
              loan.paidAmount = double.tryParse(val) ?? 0;
            },
          ),

          SizedBox(height: 8.h),

          /// PAYMENT MODE
          DropdownButtonFormField<String>(
            value: paymentModes.contains(loan.paymentMode)
                ? loan.paymentMode
                : null,
            isDense: true,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              hintText: "Payment Mode",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            items: paymentModes.map((mode) {
              return DropdownMenuItem(
                value: mode,
                child: Text(mode, style: TextStyle(fontSize: 12.sp)),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                loan.paymentMode = val!;
              });
            },
          ),

          SizedBox(height: 10.h),

          /// BUTTON SMALL
          SizedBox(
            width: double.infinity,
            height: 38.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                if (loan.paidAmount <= 0 || loan.paymentMode.isEmpty) {
                  toastification.show(
                    context: context, // optional if you use ToastificationWrapper
                    title: Text('Error Enter amount & select payment mode'),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                  return;
                }

                setState(() {
                  loan.outstanding -= loan.paidAmount;
                  loan.isPaid = true;
                });
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 12.sp,color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// MODELS
class LoanModel {
  final String name;
  final String loanId;
  final String loanType;
  final double due;
  double outstanding;

  double paidAmount;
  String paymentMode;
  bool isPaid;

  LoanModel({
    required this.name,
    required this.loanId,
    required this.loanType,
    required this.due,
    required this.outstanding,
    this.paidAmount = 0,
    this.paymentMode = "",
    this.isPaid = false,
  });
}

class GroupModel {
  final String groupName;
  final List<LoanModel> loans;

  GroupModel({required this.groupName, required this.loans});
}
