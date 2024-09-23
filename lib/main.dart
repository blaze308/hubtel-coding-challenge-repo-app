// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionHistoryScreen(),
    );
  }
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() => _tabIndex = _tabController.index);
      });

    // Simulate a 2-second loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // After 2 seconds, stop showing the loader
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), // Height of the TabBar
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color:
                    Colors.white, // Indicator background color for selected tab
                shape: BoxShape.rectangle, // Rectangle shape for indicator
                borderRadius:
                    BorderRadius.circular(30), // Rounded corners for indicator
              ),
              indicatorPadding:
                  const EdgeInsets.all(2), // Padding around the indicator
              indicatorColor:
                  Colors.amber, // This is deprecated when using BoxDecoration
              indicatorSize:
                  TabBarIndicatorSize.tab, // Indicator size spans entire tab
              labelColor: Colors.black, // Text color for the selected tab
              unselectedLabelColor:
                  Colors.grey, // Text color for unselected tabs
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, // Bold text for the selected tab
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight:
                    FontWeight.normal, // Normal text for unselected tabs
              ),
              tabs: const [
                Tab(text: 'History'),
                Tab(text: 'Transaction Summary'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            // Search bar and filter icon at the top of the page
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.tune, color: Colors.black),
                ],
              ),
            ),

            // Date label for transactions
            if (!_isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300],
                    ),
                    child: Text(
                      "May 24, 2022",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),

            // Show loading indicator or transaction cards
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(), // Loading indicator
                    )
                  : ListView(
                      children: [
                        // First transaction card
                        _buildTransactionCard(
                          time: '14:45PM',
                          name: 'Emmanuel Rockson Kwabena Uncle Ebo',
                          phoneNumber: '024 123 4567',
                          amount: 'GHS 500',
                          status: 'Successful',
                          isSuccess: true,
                          note: 'Cool your heart wai',
                          imagePath: 'assets/images/momo logo.jpeg',
                        ),
                        // Second transaction card
                        _buildTransactionCard(
                          time: '14:45PM',
                          name: 'Absa Bank',
                          phoneNumber: '024 123 4567',
                          amount: 'GHS 500',
                          status: 'Failed',
                          isSuccess: false,
                          note: 'Cool your heart wai',
                          imagePath: 'assets/images/absa logo.png',
                        ),
                      ],
                    ),
            ),

            // Bottom Navigation Bar
            BottomNavigationBar(
              currentIndex: 1,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  activeIcon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFDBF7E0),
                    child: Icon(Icons.home, color: Colors.black),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.send_to_mobile, color: Colors.grey),
                  activeIcon: Icon(Icons.send_to_mobile, color: Colors.black),
                  label: 'Send',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history, color: Colors.grey),
                  activeIcon: Icon(Icons.history, color: Colors.black),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today, color: Colors.grey),
                  activeIcon: Icon(Icons.calendar_today, color: Colors.black),
                  label: 'Scheduled',
                ),
              ],
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
            ),
          ],
        ),

        // Floating Action Button at the bottom of the screen
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFF01C7B1),
              ),
            ),
            label: const Text(
              'SEND NEW',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF01C7B1),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  // Transaction card for individual transactions
  Widget _buildTransactionCard({
    required String time,
    required String name,
    required String phoneNumber,
    required String amount,
    required String status,
    required bool isSuccess,
    required String note,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    avatar: Icon(
                      isSuccess ? Icons.check_circle : Icons.cancel,
                      color: isSuccess
                          ? const Color(0xFF70E083)
                          : const Color(0xFF991B33),
                    ),
                    label: Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: isSuccess
                            ? const Color(0xFF70E083)
                            : const Color(0xFF991B33),
                      ),
                    ),
                    backgroundColor: isSuccess
                        ? const Color(0xFFDBF7E0)
                        : const Color(0xFFFDB0AC),
                    elevation: 0,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phoneNumber,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Text(amount,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(note, style: const TextStyle(color: Colors.grey)),
                  const Spacer(),
                  const Icon(Icons.star_border, color: Colors.amber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
