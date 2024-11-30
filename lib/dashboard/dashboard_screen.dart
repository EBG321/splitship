import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning 👋',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'Andrew Ainsley',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.notifications, color: Colors.white),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Section (Fixed Width)
                  Center(
                    child: Card(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        width: 360, // Fixed width for Visa card
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Andrew Ainsley',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your balance',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Image.asset('assets/visa_logo.png', height: 40), // Replace with your logo
                              ],
                            ),
                            Text(
                              '\$9,729',
                              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                child: Text('Top Up', style: TextStyle(color: Colors.teal)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Help Center Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Help Center action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(Icons.help_outline, color: Colors.white),
                    label: Text(
                      'Help Center',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Search Box
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      hintText: 'Enter Track ID Number',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Transaction History
                  Text(
                    'Transaction History',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildTransactionTile(
                          icon: Icons.shopping_bag,
                          title: 'New Order Made!',
                          subtitle: 'You created a new shipping order 2 hours ago',
                          color: Colors.teal,
                        ),
                        _buildTransactionTile(
                          icon: Icons.account_balance_wallet,
                          title: 'Top-Up Successful!',
                          subtitle: 'You added \$600 to your e-wallet 4 hours ago',
                          color: Colors.blue,
                        ),
                        _buildTransactionTile(
                          icon: Icons.payment,
                          title: 'Payment Successful!',
                          subtitle: 'You paid \$40 for shipping 1 day ago',
                          color: Colors.green,
                        ),
                        _buildTransactionTile(
                          icon: Icons.link,
                          title: 'E-Wallet Connected!',
                          subtitle: 'You linked your e-wallet with Saska 2 days ago',
                          color: Colors.orange,
                        ),
                        _buildTransactionTile(
                          icon: Icons.local_shipping,
                          title: 'Shipment Delivered!',
                          subtitle: 'Order #12345 was delivered successfully 3 days ago',
                          color: Colors.purple,
                        ),
                        _buildTransactionTile(
                          icon: Icons.money_off,
                          title: 'Refund Processed!',
                          subtitle: 'Refund of \$120 was processed 5 days ago',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white70)),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    );
  }
}
