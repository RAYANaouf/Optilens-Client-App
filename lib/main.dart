import 'package:flutter/material.dart';
import 'widgets/bottom_navbar.dart';
import 'views/Dashboard_view.dart';
import 'views/Invoice_view.dart';
import 'views/Payment_view.dart';
import 'views/Profil_view.dart';
import 'views/login_view.dart';
import 'domain/response/Customer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  final Customer customer;

  const MainPage({super.key, required this.customer});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(customer: widget.customer),
      InvoicePage(customerCode: widget.customer.code),
      const PaymentPage(),
      ProfilePage(
        username: widget.customer.name,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
