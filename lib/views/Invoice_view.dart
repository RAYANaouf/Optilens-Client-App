import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/invoice_filter_bar.dart';
import '../utils/invoice_utils.dart';
import '../../application/controllers/invoice_controller.dart';
import '../../domain/response/InvoicesResponse.dart';
import '../../domain/response/Sales_invoice.dart';

class InvoicePage extends StatefulWidget {
  final String customerCode;

  const InvoicePage({super.key, required this.customerCode});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String searchQuery = '';
  String selectedStatus = 'All';
  DateTime? selectedDate;

  final InvoiceController controller = InvoiceController();
  List<SalesInvoice> serverItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  void fetchInvoices() async {
    setState(() {
      isLoading = true;
    });

    try {
      final InvoicesResponse? response = await controller.fetchInvoices(
        widget.customerCode,
      );

      if (response != null) {
        serverItems = response.sales_invoices;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur lors de la récupération des factures"),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  List<InvoiceItemData> get filteredItems {
    return serverItems
        .where((item) {
          final matchesSearch = item.name.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          final matchesStatus =
              selectedStatus == 'All' || item.status == selectedStatus;
          final matchesDate =
              selectedDate == null ||
              (DateTime.parse(item.posting_date).year == selectedDate!.year &&
                  DateTime.parse(item.posting_date).month ==
                      selectedDate!.month &&
                  DateTime.parse(item.posting_date).day == selectedDate!.day);

          return matchesSearch && matchesStatus && matchesDate;
        })
        .map(
          (item) => InvoiceItemData(
            title: item.name,
            ttc: item.grand_total,
            price: item.outstanding_amount,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Invoices'),

          InvoiceFilterBar(
            selectedStatus: selectedStatus,
            selectedDate: selectedDate,
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            onStatusChanged: (value) {
              setState(() {
                if (value != null) selectedStatus = value;
              });
            },
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 252, 253, 253),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : serverItems.isEmpty
                  ? const Center(child: Text('No invoices found'))
                  : SingleChildScrollView(
                      child: InvoiceList(
                        globalTitle: 'All Invoice',
                        label: "Invoice",
                        priceColor: Colors.red,
                        items: filteredItems,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
