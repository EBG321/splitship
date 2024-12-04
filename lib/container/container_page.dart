import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/container/proceed_page.dart';
import 'package:splitshipv01/home_page/home_page.dart';

class ContainerPage extends StatelessWidget {
  // Receiving the container details passed as arguments
  final String imageUrl;
  final double fillPercentage;
  final String containerType;
  final String location;
  final String dimensions;
  final double price;
  final String shippingDate;

  // Constructor to accept the container details
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
    return Scaffold(
      appBar: AppBar(
        title: Text('$containerType Details'),
        backgroundColor: Color.fromARGB(50, 0, 45, 83),
      ),
      backgroundColor: Color.fromARGB(128, 0, 26, 50),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display container image
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Display container fill percentage with progress bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 10),
                  Text(
                    '${100- (fillPercentage * 100).toInt()}% Left',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display container type with icon
              Row(
                children: [
                  Icon(
                    Icons.archive,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Container Type: $containerType',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display dimensions
              Row(
                children: [
                  Icon(
                    Icons.crop_square,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Dimensions: $dimensions',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display location with location pin icon
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Location: $location',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),


              // Display price with dollar sign icon
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Price: \$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display shipping availability with calendar icon
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Shipping Available: $shippingDate',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Action button to proceed with booking or further actions
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar("Action", "Proceed with your action for $containerType");
                    Get.to(ProceedPage(containerType: containerType));
                  },
                  child: Text('Proceed'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
      ),
    );
  }
}
