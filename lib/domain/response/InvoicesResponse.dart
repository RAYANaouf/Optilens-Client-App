import 'package:test_project/domain/response/Sales_invoice.dart';

class InvoicesResponse {
  final String customer_code;
  final List<SalesInvoice> sales_invoices;

  InvoicesResponse({required this.customer_code, required this.sales_invoices});
  static InvoicesResponse fromJson(Map<String, dynamic> json) {
    return InvoicesResponse(
      customer_code: json["message"]["customer_code"],
      sales_invoices: (json["message"]["sales_invoices"] as List)
          .map((s) => SalesInvoice.fromJson(s))
          .toList(),
    );
  }
}
