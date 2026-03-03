import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imayam/theme/app_colors.dart';

class NewLoanScreen extends StatefulWidget {
  const NewLoanScreen({super.key});

  @override
  State<NewLoanScreen> createState() => _NewLoanScreenState();
}

class _NewLoanScreenState extends State<NewLoanScreen> {
  String selectedLoanType = "Individual";
  String selectedCustomer = "";
  String selectedCollection = "Daily";

  List<String> loanTypes = ["Individual", "Group"];

  List<Map<String, String>> customers = [
    {"name": "Lakshmi Devi", "code": "CUST001"},
    {"name": "Savitri Bai", "code": "CUST002"},
    {"name": "Meena Kumari", "code": "CUST003"},
  ];

  List<String> collectionTypes = ["Daily", "Weekly", "Monthly"];

  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();

  double totalAmount = 0;
  void _calculateTotal() {
    double loanAmount =
        double.tryParse(loanAmountController.text) ?? 0;
    double interest =
        double.tryParse(interestController.text) ?? 0;
    double tenure =
        double.tryParse(tenureController.text) ?? 0;

    double interestAmount = (loanAmount * interest) / 100;
    double singleTotal = loanAmount + interestAmount;

    setState(() {
      totalAmount = singleTotal * tenure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: const BackButton(color: Colors.white),
        title: Text(
          "New Loan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.w),
        child: SizedBox(
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6FED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "Create Loan",
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// Customer
            _sectionTitle("Select Customer"),
            _customerDropdown(),

            SizedBox(height: 18.h),

            /// Loan Details
            /// Loan Details
            _sectionTitle("Loan Details"),

            _inputField(
              "Loan Amount *",
              "Enter amount",
              controller: loanAmountController,
            ),

            _inputField(
              "Interest Rate (%)",
              "0%",
              controller: interestController,
            ),

            _inputField(
              "Tenure (Weeks)",
              "52",
              controller: tenureController,
            ),

            SizedBox(height: 14.h),

            /// Collection
            _sectionTitle("Collection Frequency"),
            _dropdownField(
              value: selectedCollection,
              items: collectionTypes,
              onChanged: (val) {
                setState(() {
                  selectedCollection = val!;
                });
              },
            ),

            SizedBox(height: 16.h),

            Container(
              height: 40.h,
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "₹ ${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2F6FED),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SMALL SIZE WIDGETS ----------------

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDCE3F0)),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        items: items
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _customerDropdown() {
    return GestureDetector(
      onTap: _openCustomerDialog,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFDCE3F0)),
        ),
        child: Row(
          children: [
            Container(
              height: 32.h,
              width: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF2F6FED).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 18,
                color: Color(0xFF2F6FED),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: selectedCustomer.isEmpty
                  ? Text(
                "Select Customer",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              )
                  : Text(
                selectedCustomer,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
    );
  }

  void _openCustomerDialog() {
    TextEditingController searchController = TextEditingController();
    List<Map<String, String>> filteredCustomers = List.from(customers);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                children: [

                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Select Customer",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FB),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(fontSize: 13.sp),
                        prefixIcon:
                        const Icon(Icons.search, size: 18),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      onChanged: (value) {
                        setStateSB(() {
                          filteredCustomers = customers
                              .where((cust) =>
                          cust["name"]!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                              cust["code"]!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = filteredCustomers[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCustomer =
                              "${customer["name"]} (${customer["code"]})";
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin:
                            EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12.r),
                              border: Border.all(
                                  color:
                                  const Color(0xFFE3E8F2)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 28.h,
                                  width: 28.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F6FED)
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(
                                        8.r),
                                  ),
                                  child: Text(
                                    customer["name"]![0],
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: const Color(
                                          0xFF2F6FED),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customer["name"]!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      customer["code"]!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _inputField(
      String label,
      String hint, {
        required TextEditingController controller,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            height: 45.h,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) => _calculateTotal(),
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13.sp),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                      color: Color(0xFFDCE3F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                      color: Color(0xFFDCE3F0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoanModel {
  final String name;
  final String loanId;
  final String loanType;
  final double due;
  final double outstanding;

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