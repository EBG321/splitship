import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_us.dart';
class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color with some opacity
                          blurRadius: 8, // How soft the shadow is
                          spreadRadius: 2, // Spread radius of the shadow
                          offset: Offset(4, 4), // Offset of the shadow
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/logo.png', // Replace with your actual image path
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome to SplitShip',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Introduction Section
            Text(
              'Who We Are',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'SplitShip is a revolutionary platform designed to help individuals and companies save on shipping costs. By enabling users to share container space, we ensure that no one has to pay for empty space they don’t need.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 24),

            // Purpose Section
            Text(
              'Our Purpose',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We believe in making shipping more efficient, affordable, and eco-friendly. Our platform connects people who have extra container space with those who need it, reducing costs and minimizing environmental impact.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 24),

            // Benefits Section
            Text(
              'Why Use SplitShip?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.blue),
              title: Text(
                'Save Money',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Share the cost of shipping by using only the space you need.',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.eco, color: Colors.blue),
              title: Text(
                'Eco-Friendly',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Reduce your carbon footprint by making full use of available container space.',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.network_check, color: Colors.blue),
              title: Text(
                'Easy and Convenient',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Our platform makes it simple to find available container space or fill your own.',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 24),

            // Get in Touch Section
            Text(
              'Get in Touch',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Have questions or want to learn more? Contact our team at SplitShip. We’re here to help!',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.email, color: Colors.black),
                label: Text('Contact Us', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.to(ContactUsPage()); // Corrected this to Get.to()
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}





