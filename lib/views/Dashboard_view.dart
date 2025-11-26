import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../utils/invoice_utils.dart';
import '../../application/controllers/invoice_controller.dart';
import '../../domain/response/InvoicesResponse.dart';
import '../../domain/response/Sales_invoice.dart';
import '../../domain/response/Customer.dart';

class DashboardPage extends StatefulWidget {
  final Customer customer;

  const DashboardPage({super.key, required this.customer});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final InvoiceController controller = InvoiceController();
  List<SalesInvoice> invoices = [];
  bool isLoading = true;
  double totalOutstanding = 0;

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  void fetchInvoices() async {
    setState(() => isLoading = true);

    final InvoicesResponse? response = await controller.fetchInvoices(
      widget.customer.code,
    );

    setState(() {
      if (response != null) {
        invoices = response.sales_invoices;
        totalOutstanding = invoices.fold(
          0,
          (sum, item) => sum + item.outstanding_amount,
        );
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 252, 253, 253),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  const AppHeader(title: 'Dashboard'),
                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Outstanding Amount',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.customer.debt.toStringAsFixed(2)} DA',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  InvoiceList(
                    globalTitle: "Recent Invoices",
                    label: "Invoice",
                    priceColor: Colors.red,
                    items: invoices
                        .map(
                          (item) => InvoiceItemData(
                            title: item.name,
                            ttc: item.grand_total,
                            price: item.outstanding_amount,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
