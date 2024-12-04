import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/dashboard/dashboard_screen.dart';

class ProceedPage extends StatelessWidget {
  final String containerType;

  ProceedPage({Key? key, required this.containerType}) : super(key: key);

  final selectedCard = RxString('Visa **** 1234'); // Default selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proceed with $containerType'),
        backgroundColor: Color.fromARGB(255, 0, 45, 83),
      ),
      backgroundColor: Color.fromARGB(255, 0, 45, 83),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Input
            Text(
              'Enter Delivery Address',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Street, City, State, ZIP Code',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Payment Method Section
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),

            // List of saved cards
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Obx(() => ListTile(
                    leading: Icon(Icons.credit_card, color: Colors.blue),
                    title: Text('Visa **** 1234'),
                    subtitle: Text('Expires 12/25'),
                    trailing: Icon(
                      selectedCard.value == 'Visa **** 1234'
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: selectedCard.value == 'Visa **** 1234'
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onTap: () {
                      selectedCard.value = 'Visa **** 1234';
                    },
                  )),
                  Divider(),
                  Obx(() => ListTile(
                    leading: Icon(Icons.credit_card, color: Colors.blue),
                    title: Text('MasterCard **** 5678'),
                    subtitle: Text('Expires 10/24'),
                    trailing: Icon(
                      selectedCard.value == 'MasterCard **** 5678'
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: selectedCard.value == 'MasterCard **** 5678'
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onTap: () {
                      selectedCard.value = 'MasterCard **** 5678';
                    },
                  )),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Proceed Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar('Success', 'Payment confirmed for $containerType');
                  Get.to(WalletPage());
                },
                child: Text('Confirm and Proceed'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: Colors.blue.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
