import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/invoice_filter_bar.dart';
import '../utils/payment_utils.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String searchQuery = '';
  String selectedStatus = 'All';
  DateTime? selectedDate;

  final List<PaymentItemData> allPayments = [
    PaymentItemData(
      paymentId: 'PAY-059448',
      invoiceId: 'FV/2025/029669',
      date: '21/11/2025',
      amount: 17960,
    ),
    PaymentItemData(
      paymentId: 'PAY-059449',
      invoiceId: 'FV/2025/029670',
      date: '20/11/2025',
      amount: 12500,
    ),
    PaymentItemData(
      paymentId: 'PAY-059450',
      invoiceId: 'FV/2025/029671',
      date: '19/11/2025',
      amount: 9800,
    ),
    PaymentItemData(
      paymentId: 'PAY-059451',
      invoiceId: 'FV/2025/029672',
      date: '18/11/2025',
      amount: 15000,
    ),
    PaymentItemData(
      paymentId: 'PAY-059452',
      invoiceId: 'FV/2025/029673',
      date: '17/11/2025',
      amount: 20000,
    ),
  ];

  List<PaymentItemData> get filteredPayments {
    return allPayments.where((item) {
      return item.paymentId.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Payments'),

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
            child: SingleChildScrollView(
              child: PaymentList(
                globalTitle: 'All Payments',
                items: filteredPayments,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
