import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class CollectionBillGenerator {

  static Future generate({
    required String customer,
    required String loanId,
    required String group,
    required double collected,
    required double total,
    required String paymentMode,
    required String remarks,
  }) async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final receiptNo = "RCPT${now.millisecondsSinceEpoch}";
    final date =
        "${now.day}/${now.month}/${now.year}  ${now.hour}:${now.minute}";

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              /// HEADER
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      "Arupadai Finance",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      "COLLECTION RECEIPT",
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),
              pw.Divider(),

              /// RECEIPT INFO ROW
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Receipt No: $receiptNo"),
                  pw.Text("Date: $date"),
                ],
              ),

              pw.SizedBox(height: 20),

              /// CUSTOMER DETAILS SECTION
              pw.Text(
                "Customer Details",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Column(
                  children: [
                    _detailRow("Customer Name", customer),
                    _detailRow("Loan ID", loanId),
                    _detailRow("Group", group),
                    _detailRow("Payment Mode", paymentMode),
                  ],
                ),
              ),

              pw.SizedBox(height: 25),

              /// PAYMENT DETAILS
              pw.Text(
                "Payment Summary",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(2),
                },
                children: [
                  _tableRow(
                    "Collected Amount",
                    "₹${collected.toStringAsFixed(2)}",
                  ),
                  _tableRow(
                    "Total Paid",
                    "₹${total.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              /// REMARKS (if available)
              if (remarks.isNotEmpty) ...[
                pw.Text(
                  "Remarks",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 6),
                pw.Text(remarks),
                pw.SizedBox(height: 20),
              ],

              pw.Spacer(),
              pw.Divider(),

              /// FOOTER
              pw.Center(
                child: pw.Text(
                  "Thank You For Your Payment",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file =
    File("${dir.path}/collection_$receiptNo.pdf");

    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
  static pw.Widget _detailRow(String title, String value,
      {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight:
              isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  static pw.TableRow _tableRow(String title, String value,
      {bool isBold = false}) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight:
              isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontWeight:
              isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

}
