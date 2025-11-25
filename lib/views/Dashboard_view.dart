import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../utils/invoice_utils.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceItems = [
      InvoiceItemData(title: "F/POS/2025/165149", ttc: 17960.0, price: 17960.0),
      InvoiceItemData(title: "F/POS/2025/165150", ttc: 12500.0, price: 12500.0),
      InvoiceItemData(title: "F/POS/2025/165151", ttc: 9800.0, price: 9800.0),
      InvoiceItemData(title: "F/POS/2025/165152", ttc: 15000.0, price: 15000.0),
      InvoiceItemData(title: "F/POS/2025/165153", ttc: 20000.0, price: 20000.0),
      InvoiceItemData(title: "F/POS/2025/165153", ttc: 20000.0, price: 20000.0),
      InvoiceItemData(title: "F/POS/2025/165153", ttc: 20000.0, price: 20000.0),
      InvoiceItemData(title: "F/POS/2025/165153", ttc: 20000.0, price: 20000.0),
    ];

    return Container(
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
              children: const [
                Text(
                  'Outstanding Amount',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '125,000 DA',
                  style: TextStyle(
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
            items: invoiceItems,
          ),
        ],
      ),
    );
  }
}
