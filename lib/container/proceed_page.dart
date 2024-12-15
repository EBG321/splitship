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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.teal),
        title: Text(
          'Proceed with $containerType',
          style: const TextStyle(color: Colors.teal),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Input
            const Text(
              'Enter Delivery Address',
              style: TextStyle(fontSize: 18, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Street, City, State, ZIP Code',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900]?.withOpacity(0.7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Method Section
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, color: Colors.teal),
            ),
            const SizedBox(height: 10),

            // List of saved cards
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[900]?.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Obx(() => ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.teal),
                    title: const Text(
                      'Visa **** 1234',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      'Expires 12/25',
                      style: TextStyle(color: Colors.white70),
                    ),
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
                  const Divider(color: Colors.white24),
                  Obx(() => ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.teal),
                    title: const Text(
                      'MasterCard **** 5678',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      'Expires 10/24',
                      style: TextStyle(color: Colors.white70),
                    ),
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
            const SizedBox(height: 20),

            // Proceed Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    'Success',
                    'Payment confirmed for $containerType',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.teal,
                    colorText: Colors.white,
                  );
                  Get.to(WalletPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm and Proceed',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
