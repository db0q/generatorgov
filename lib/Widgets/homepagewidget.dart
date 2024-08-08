import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart'; // Import the ProfilePage here

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example data for houses with unpaid and paid bills
  final List<Map<String, dynamic>> houses = [
    {
      'houseId': 'H001',
      'address': '123 Main St',
      'unpaidBills': [
        {'id': '001', 'amount': 100, 'dueDate': '2024-08-10'},
        {'id': '002', 'amount': 250, 'dueDate': '2024-08-15'},
      ],
      'paidBills': [
        {'id': '003', 'amount': 150, 'paymentDate': '2024-07-25'},
        {'id': '004', 'amount': 200, 'paymentDate': '2024-07-30'},
      ],
    },
    {
      'houseId': 'H002',
      'address': '456 Elm St',
      'unpaidBills': [
        {'id': '005', 'amount': 300, 'dueDate': '2024-08-20'},
      ],
      'paidBills': [
        {'id': '006', 'amount': 400, 'paymentDate': '2024-07-20'},
      ],
    },
  ];

  void _payBill(String houseId, String billId) {
    // Handle the pay bill logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paying bill with ID: $billId for house: $houseId')),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0), // Adjusted height
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _navigateToProfile,
                    child: CircleAvatar(
                      radius: 25, // Adjusted radius for a smaller circle
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.teal, size: 25), // Adjusted icon size
                    ),
                  ),
                ),
                const SizedBox(height: 8.0), // Space between the circle and the TabBar
                Container(
                  color: Colors.teal[800],
                  child: TabBar(
                    tabs: const [
                      Tab(
                        text: 'الفواتير غير المدفوعة',
                        icon: Icon(Icons.list_alt, color: Colors.white),
                      ),
                      Tab(
                        text: 'الفواتير المدفوعة',
                        icon: Icon(Icons.check_circle, color: Colors.white),
                      ),
                    ],
                    labelStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
                    labelColor: Colors.white,
                    indicatorColor: Colors.orange,
                    indicatorWeight: 3.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildHousesContainer(houses, 'unpaidBills', 'غير مدفوعة', isPaid: false),
            _buildHousesContainer(houses, 'paidBills', 'مدفوعة', isPaid: true),
          ],
        ),
      ),
    );
  }

  Widget _buildHousesContainer(List<Map<String, dynamic>> houses, String billType, String type, {required bool isPaid}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: houses.isEmpty
          ? Center(
              child: Text(
                'لا توجد فواتير $type',
                style: GoogleFonts.almarai(fontSize: 18, color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: houses.length,
              itemBuilder: (context, index) {
                final house = houses[index];
                final bills = house[billType];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المنزل: ${house['address']}',
                      style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bills.length,
                      itemBuilder: (context, billIndex) {
                        final bill = bills[billIndex];
                        return Card(
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(16.0),
                                title: Text('فاتورة رقم: ${bill['id']}', style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  isPaid
                                      ? 'المبلغ: ${bill['amount']} - تاريخ الدفع: ${bill['paymentDate']}'
                                      : 'المبلغ: ${bill['amount']} - تاريخ الاستحقاق: ${bill['dueDate']}',
                                  style: GoogleFonts.almarai(fontSize: 16, color: const Color.fromARGB(255, 97, 97, 97)),
                                ),
                                trailing: Icon(
                                  isPaid ? Icons.check_circle : Icons.payment,
                                  color: Colors.teal,
                                ),
                              ),
                              if (!isPaid)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () => _payBill(house['houseId'], bill['id']),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Colors.teal,
                                      minimumSize: const Size(double.infinity, 36),
                                    ),
                                    child: Text('دفع الفاتورة', style: GoogleFonts.almarai(fontSize: 16)),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                );
              },
            ),
    );
  }
}
