import 'package:test_project/domain/response/Sales_invoice.dart';

class Test {
  final String customer_code;
  final List<SalesInvoice> sales_invoices;

  Test({required this.customer_code, required this.sales_invoices});
  static Test fromJson(Map<String, dynamic> json) {
    return Test(
      customer_code: json["message"]["customer_code"],
      sales_invoices: (json["message"]["sales_invoices"] as List)
          .map((s) => SalesInvoice.fromJson(s))
          .toList(),
    );
  }
}
