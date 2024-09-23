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
  final colors = [
    const Color(0xFF64c636),
    const Color(0xFFf2c32c),
    const Color(0xFF00a9ce),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() => _tabIndex = _tabController.index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // TabBar for navigating between History and Transaction Summary
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.white, // Background color for the selected tab
              borderRadius: BorderRadius.circular(
                  16.0), // Rounded corners for the selected tab
            ),
            labelColor: Colors.black, // Text color for selected tab
            unselectedLabelColor: Colors.grey, // Text color for unselected tabs
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, // Bold text for selected tab
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal, // Normal text for unselected tabs
            ),
            tabs: const [
              Tab(text: 'History'), // First tab
              Tab(text: 'Transaction Summary'), // Second tab
            ],
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
                        hintText: 'Search', // Placeholder for search field
                        prefixIcon: const Icon(Icons.search), // Search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Rounded corners for search field
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[
                            200], // Light grey background for the search field
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.tune, color: Colors.black), // Filter icon
                ],
              ),
            ),

            // Date label for transactions
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Padding inside the date container
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          30), // Circular radius for date container
                      color: Colors.grey[
                          300]), // Light grey background for date container
                  child: Text(
                    "May 24, 2022", // Date text
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            // List of transaction cards
            Expanded(
              child: ListView(
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
                    imagePath:
                        'assets/images/momo logo.jpeg', // Path for the logo image
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
                    imagePath:
                        'assets/images/absa logo.png', // Path for the logo image
                  ),
                ],
              ),
            ),

            // Bottom Navigation Bar
            BottomNavigationBar(
              currentIndex: 1, // Selected index
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  activeIcon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(
                        0xFFDBF7E0), // Active background color for the icon
                    child: Icon(Icons.home,
                        color: Colors.black), // Active icon color
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
              selectedItemColor: Colors.black, // Text color for selected item
              unselectedItemColor:
                  Colors.grey, // Text color for unselected items
              showUnselectedLabels: true, // Show labels for unselected items
              type: BottomNavigationBarType
                  .fixed, // Fixed tabs in the bottom navigation
            ),
          ],
        ),

        // Floating Action Button at the bottom of the screen
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // White background for the plus icon
              ),
              child: Icon(
                Icons.add, // Black plus sign
                color: Color(0xFF01C7B1), // Plus icon color
              ),
            ),
            label: const Text(
              'SEND NEW',
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
            backgroundColor: Color(0xFF01C7B1), // Button background color
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .centerFloat, // Center the FAB at the bottom
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
    required String imagePath, // Path for the dynamic logo image
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10)), // Rounded corners for the card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time of the transaction
              Text(time, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),

              // Row for Name and Status (Successful/Failed) on the same line
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name, // Name of the person
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          softWrap: true, // Allow name to wrap if it's too long
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    avatar: Icon(
                      isSuccess
                          ? Icons.check_circle
                          : Icons.cancel, // Show success or failure icon
                      color: isSuccess ? Color(0xFF70E083) : Color(0xFF991B33),
                    ),
                    label: Text(
                      status, // Status text (Successful/Failed)
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color:
                            isSuccess ? Color(0xFF70E083) : Color(0xFF991B33),
                      ),
                    ),
                    backgroundColor: isSuccess
                        ? Color(0xFFDBF7E0)
                        : Color(
                            0xFFFDB0AC), // Background color for success or failure
                    elevation: 0, // No shadow for the chip
                    side: BorderSide.none, // No border for the chip
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Rounded corners for the chip
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Row for Avatar and Transaction Details (Amount, Phone Number)
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      imagePath, // Dynamic image path passed here
                      fit: BoxFit.cover, // Ensure the image fills the oval
                      width: 60, // The width of the avatar
                      height: 60, // The height of the avatar
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phoneNumber,
                          style: const TextStyle(
                              color: Colors.grey)), // Phone number
                    ],
                  ),
                  const Spacer(),
                  Text(amount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)), // Transaction amount
                ],
              ),

              const SizedBox(height: 10),

              // Additional notes and star icon for rating
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(note,
                      style: const TextStyle(
                          color: Colors.grey)), // Additional note
                  const Spacer(),
                  const Icon(Icons.star_border,
                      color: Colors.amber), // Star icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
