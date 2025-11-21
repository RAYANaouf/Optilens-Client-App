import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/invoice_filter_bar.dart';
import '../utils/invoice_utils.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String searchQuery = '';
  String selectedStatus = 'All';
  DateTime? selectedDate;

  final List<InvoiceItemData> allItems = [
    InvoiceItemData(title: "F/POS/2025/165149", ttc: 17960.0, price: 17960.0),
    InvoiceItemData(title: "F/POS/2025/165150", ttc: 12500.0, price: 12500.0),
    InvoiceItemData(title: "F/POS/2025/165151", ttc: 9800.0, price: 9800.0),
    InvoiceItemData(title: "F/POS/2025/165152", ttc: 15000.0, price: 15000.0),
    InvoiceItemData(title: "F/POS/2025/165153", ttc: 20000.0, price: 20000.0),
  ];

  List<InvoiceItemData> get filteredItems {
    return allItems.where((item) {
      final matchesSearch = item.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      // Ici tu peux appliquer filtre date/status si tu as ces infos
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header fixe
          const AppHeader(title: 'Invoices'),

          // Appel du widget de recherche + filtres
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

          // Liste scrollable
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 252, 253, 253),
              child: SingleChildScrollView(
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
