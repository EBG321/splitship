import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/container/proceed_page.dart';

class ContainerPage extends StatelessWidget {
  final String imageUrl;
  final double fillPercentage;
  final String containerType;
  final String location;
  final String dimensions;
  final double price;
  final String shippingDate;

  const ContainerPage({
    Key? key,
    required this.imageUrl,
    required this.fillPercentage,
    required this.containerType,
    required this.location,
    required this.dimensions,
    required this.price,
    required this.shippingDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Determine image height
    final double imageHeight = screenSize.width > screenSize.height
        ? screenSize.height * 0.6
        : 300.0; // Cast to double explicitly

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.teal),
        title: Text(
          '$containerType Details',
          style: const TextStyle(color: Colors.teal),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container image
              Container(
                width: double.infinity,
                height: imageHeight, // Use the calculated height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0), // Cast radius as double
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8.0, // Cast blur radius as double
                      offset: const Offset(0.0, 4.0), // Cast offset values as double
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Fill percentage
              Text(
                '${100 - (fillPercentage * 100).toInt()}% Space Remaining',
                style: const TextStyle(
                  fontSize: 20.0, // Cast font size as double
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),

              // Details section
              _buildDetailRow(Icons.archive, 'Container Type', containerType),
              const SizedBox(height: 10.0),
              _buildDetailRow(Icons.crop_square, 'Dimensions', dimensions),
              const SizedBox(height: 10.0),
              _buildDetailRow(Icons.location_on, 'Location', location),
              const SizedBox(height: 10.0),
              _buildDetailRow(Icons.attach_money, 'Price',
                  '\$${price.toStringAsFixed(2)}'),
              const SizedBox(height: 10.0),
              _buildDetailRow(Icons.calendar_today, 'Shipping Date', shippingDate),
              const SizedBox(height: 30.0),

              // Proceed button
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Action",
                    "Proceeding with your action for $containerType",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.teal,
                    colorText: Colors.white,
                  );
                  Get.to(ProceedPage(containerType: containerType));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ), // Cast padding as double
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(IconData icon, String title, String detail) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal, size: 24.0), // Cast icon size as double
        const SizedBox(width: 10.0), // Cast width as double
        Expanded(
          child: Text(
            '$title: $detail',
            style: const TextStyle(
              fontSize: 16.0, // Cast font size as double
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
