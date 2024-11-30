import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../about_us/about_us.dart';
import '../about_us/contact_us.dart';
import '../account setup/account_setup_screen.dart';
import '../auth_screen/login_screen.dart';
import '../container/container_page.dart';
import 'home_page_controller.dart';

class SplitShipPage extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());


  final List<Map<String, dynamic>> containers = [
    {
      'imageUrl':
      'https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg',
      'fillPercentage': 0.75,
      'container_type': 'dry container',
      'location': 'Los Angeles, CA',
      'dimensions': '40ft x 8ft x 8.5ft',
      'price': 150.00,
      'shippingDate': 'Available from Dec 10, 2024',
    },
    {
      'imageUrl':
      'https://s.alicdn.com/@sc04/kf/HTB1628mX5zxK1Rjy1zk761HrVXae.png_720x720q50.png',
      'fillPercentage': 0.50,
      'container_type': 'Flat rack container',
      'location': 'New York, NY',
      'dimensions': '20ft x 8ft x 8ft',
      'price': 120.00,
      'shippingDate': 'Available from Nov 15, 2024',
    },
    {
      'imageUrl':
      'https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg',
      'fillPercentage': 0.80,
      'container_type': 'dry container',
      'location': 'Miami, FL',
      'dimensions': '40ft x 8ft x 9.5ft',
      'price': 160.00,
      'shippingDate': 'Available from Dec 5, 2024',
    },
    {
      'imageUrl':
      'https://www.boxman.co.nz/wp-content/uploads/2022/06/f_158_01_Boxman_20ft_open_top_container.jpg',
      'fillPercentage': 0.30,
      'container_type': 'Open top container',
      'location': 'Chicago, IL',
      'dimensions': '20ft x 8ft x 8ft',
      'price': 110.00,
      'shippingDate': 'Available from Nov 20, 2024',
    },
    {
      'imageUrl':
      'https://www.cascadecontainer.com/cdn/shop/files/40_STD_Double_Door_jpg.webp?v=1702774703',
      'fillPercentage': 0.40,
      'container_type': 'Double door container',
      'location': 'Houston, TX',
      'dimensions': '40ft x 8ft x 8.5ft',
      'price': 140.00,
      'shippingDate': 'Available from Dec 1, 2024',
    },
    {
      'imageUrl':
      'https://s.alicdn.com/@sc04/kf/H51898bfdd42941a6b48afa4fedea05e1m.jpg_720x720q50.jpg',
      'fillPercentage': 0.55,
      'container_type': 'ISO Reefer container',
      'location': 'San Francisco, CA',
      'dimensions': '40ft x 8ft x 9.5ft',
      'price': 180.00,
      'shippingDate': 'Available from Dec 10, 2024',
    },
    {
      'imageUrl':
      'https://image.made-in-china.com/202f0j00OuZbvTNCMkqW/40-Foot-Aluminum-Alloy-ISO-Tank-Container-for-Fuel.jpg',
      'fillPercentage': 0.69,
      'container_type': 'tank container',
      'location': 'Dallas, TX',
      'dimensions': '40ft x 8ft x 9ft',
      'price': 200.00,
      'shippingDate': 'Available from Nov 30, 2024',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 0, 45, 83),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/logo.png', // Replace with your actual image path
          height: 100,
        ),
        backgroundColor: Color.fromARGB(0, 0, 45, 83),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {Get.to(AboutUsPage());},
              child: Text("About Us"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                Get.to(ContactUsPage());
              },
              child: Text("Contact Us"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Row(
                  children: [Icon(Icons.person_outline), Text("   SING UP")],
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        // Allows vertical scrolling if needed
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for From and To dropdowns with More Filters button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 'From' Dropdown wrapped in its own Obx
                Flexible(
                  child: Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'From',
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: locationController.fromLocation.value.isEmpty
                            ? null
                            : locationController.fromLocation.value,
                        items: locationController.locations
                            .map((location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null)
                            locationController.setFromLocation(value);
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      )),
                ),
                SizedBox(width: 16),
                // 'To' Dropdown wrapped in its own Obx
                Flexible(
                  child: Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'To',
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          prefixIcon: Icon(Icons.flag, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: locationController.toLocation.value.isEmpty
                            ? null
                            : locationController.toLocation.value,
                        items: locationController.locations
                            .map((location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null)
                            locationController.setToLocation(value);
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      )),
                ),
                SizedBox(width: 50),
                // More Filters Button
                Flexible(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.filter_list, color: Colors.blue),
                    label: Text('More Filters',
                        style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('More Filter Options'),
                          content: Text(
                              'Additional filters like, date, type, dimention, type, sorting.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            // Container fill widgets displayed based on location selection
            Obx(() {
              if (locationController.fromLocation.value.isEmpty ||
                  locationController.toLocation.value.isEmpty) {
                return Text("Select 'From' and 'To' locations to view containers.", style: TextStyle(fontSize: 25),);
              }

              // Display list of container widgets after selection
              return Wrap(
                spacing: 16, // Space between containers
                runSpacing: 16, // Space between rows of containers
                children: containers.map((container) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(ContainerPage(
                        imageUrl: container['imageUrl'],
                        fillPercentage: container['fillPercentage'],
                        containerType: container['container_type'],
                        location: "${locationController.fromLocation} to ${locationController.toLocation}",
                        dimensions: container['dimensions'],
                        price: container['price'],
                        shippingDate: container['shippingDate'],
                      ));
                    },
                    child: ContainerFillWidget(
                      imageUrl: container['imageUrl'],
                      fillPercentage: container['fillPercentage'],
                      containerType: container['container_type'],
                    ),
                  );
                }).toList(),
              );
            })
          ],
        ),
      ),
    );
  }
}

// ContainerFillWidget with overlay
class ContainerFillWidget extends StatelessWidget {
  final String imageUrl;
  final double fillPercentage;
  final String containerType;

  const ContainerFillWidget({
    Key? key,
    required this.imageUrl,
    required this.fillPercentage,
    required this.containerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                // Background image
                Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Blue overlay with rounded edges
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [fillPercentage, fillPercentage],
                        ),
                      ),
                    ),
                  ),
                ),
                // Fill percentage text inside the image
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '${(fillPercentage * 100).toInt()}% Filled',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container type text below the image
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            containerType,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
