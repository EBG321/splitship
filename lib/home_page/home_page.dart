import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../about_us/about_us.dart';
import '../about_us/contact_us.dart';
import '../auth_screen/login_screen.dart';
import '../container/container_page.dart';
import '../dashboard/dashboard_screen.dart';
import 'home_page_controller.dart';
import 'price_controller.dart';
import 'user_controller.dart'; // Import the UserController
// final List<Map<String, dynamic>> containers = [
//   {
//     'imageUrl':
//     'https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg',
//     'fillPercentage': 0.75,
//     'container_type': 'dry container',
//     'location': 'Los Angeles, CA',
//     'dimensions': '40ft x 8ft x 8.5ft',
//     'price': 150.00,
//     'shippingDate': 'Available from Dec 10, 2024',
//   },
//   {
//     'imageUrl':
//     'https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg',
//     'fillPercentage': 0.10,
//     'container_type': 'dry container',
//     'location': 'Los Angeles, CA',
//     'dimensions': '40ft x 8ft x 8.5ft',
//     'price': 200.00,
//     'shippingDate': 'Available from Dec 10, 2024',
//   },
//   {
//     'imageUrl':
//     'https://s.alicdn.com/@sc04/kf/HTB1628mX5zxK1Rjy1zk761HrVXae.png_720x720q50.png',
//     'fillPercentage': 0.50,
//     'container_type': 'Flat rack container',
//     'location': 'New York, NY',
//     'dimensions': '20ft x 8ft x 8ft',
//     'price': 120.00,
//     'shippingDate': 'Available from Nov 15, 2024',
//   },
//   {
//     'imageUrl':
//     'https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg',
//     'fillPercentage': 0.80,
//     'container_type': 'dry container',
//     'location': 'Miami, FL',
//     'dimensions': '40ft x 8ft x 9.5ft',
//     'price': 160.00,
//     'shippingDate': 'Available from Dec 5, 2024',
//   },
//   {
//     'imageUrl':
//     'https://www.boxman.co.nz/wp-content/uploads/2022/06/f_158_01_Boxman_20ft_open_top_container.jpg',
//     'fillPercentage': 0.30,
//     'container_type': 'Open top container',
//     'location': 'Chicago, IL',
//     'dimensions': '20ft x 8ft x 8ft',
//     'price': 110.00,
//     'shippingDate': 'Available from Nov 20, 2024',
//   },
//   {
//     'imageUrl':
//     'https://www.cascadecontainer.com/cdn/shop/files/40_STD_Double_Door_jpg.webp?v=1702774703',
//     'fillPercentage': 0.40,
//     'container_type': 'Double door container',
//     'location': 'Houston, TX',
//     'dimensions': '40ft x 8ft x 8.5ft',
//     'price': 140.00,
//     'shippingDate': 'Available from Dec 1, 2024',
//   },
//   {
//     'imageUrl':
//     'https://s.alicdn.com/@sc04/kf/H51898bfdd42941a6b48afa4fedea05e1m.jpg_720x720q50.jpg',
//     'fillPercentage': 0.55,
//     'container_type': 'ISO Reefer container',
//     'location': 'San Francisco, CA',
//     'dimensions': '40ft x 8ft x 9.5ft',
//     'price': 180.00,
//     'shippingDate': 'Available from Dec 10, 2024',
//   },
// ];

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../about_us/about_us.dart';
import '../about_us/contact_us.dart';
import '../auth_screen/login_screen.dart';
import '../container/container_page.dart';
import 'home_page_controller.dart';
import 'price_controller.dart';
import 'user_controller.dart';

class SplitShipPage extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final UserController userController = Get.put(UserController());
  final PriceController priceController = Get.put(PriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 0, 45, 83),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset('assets/logo.png', height: 100),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () => Get.to(AboutUsPage()), child: Text("About Us")),
          TextButton(
              onPressed: () => Get.to(ContactUsPage()),
              child: Text("Contact Us")),
          Obx(() {
            return userController.isLoggedIn.value
                ? ElevatedButton(
                    onPressed: () => Get.to(WalletPage()),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                        SizedBox(width: 8),
                        Text("Dashboard")
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      userController.isLoggedIn.value = true;
                      Get.to(LoginScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.person_outline),
                        Text("   Sign Up")
                      ],
                    ),
                  );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Obx(() => _buildDropdown(
                    context,
                    label: 'From',
                    icon: Icons.location_on,
                    value: locationController.fromLocation.value,
                    items: locationController.locations,
                    onChanged: locationController.setFromLocation,
                  )),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Obx(() => _buildDropdown(
                    context,
                    label: 'To',
                    icon: Icons.flag,
                    value: locationController.toLocation.value,
                    items: locationController.locations,
                    onChanged: locationController.setToLocation,
                  )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.filter_list, color: Colors.blue),
                label: Text(
                  'More Filters',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () => _showFilterDialog(context),
              ),
            ),
            SizedBox(height: 30),
            Obx(() {
              if (locationController.fromLocation.value.isEmpty ||
                  locationController.toLocation.value.isEmpty) {
                return Text(
                  "Select 'From' and 'To' locations to view containers.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                );
              }

              return FutureBuilder<List<Map<String, dynamic>>>(
                future: locationController.fetchContainersByCountry(
                    locationController.fromLocation.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No containers available.'));
                  }

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: snapshot.data!.map((container) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(ContainerPage(
                            imageUrl: container['imageUrl'],
                            fillPercentage: container['fillPercentage'],
                            containerType: container['container_type'],
                            location:
                            "${locationController.fromLocation.value} to ${locationController.toLocation.value}",
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
                },
              );
            }),
          ],
        ),
      ),

    );
  }

  DropdownButtonFormField<String> _buildDropdown(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.blue.shade50,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      value: value?.isEmpty ?? true ? null : value,
      items: items
          .map((location) =>
              DropdownMenuItem(value: location, child: Text(location)))
          .toList(),
      onChanged: onChanged,
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container Type Filter
            Obx(() {
              return DropdownButtonFormField<String>(
                value: locationController.selectedContainerType.value.isEmpty
                    ? null
                    : locationController.selectedContainerType.value,
                hint: Text('Select Container Type'),
                items: locationController.containerTypes.map((type) {
                  return DropdownMenuItem<String>(
                      value: type, child: Text(type));
                }).toList(),
                onChanged: locationController.setContainerType,
              );
            }),
            SizedBox(height: 16),
            // Max Price Filter
            Text(
                'Max Price: \$${priceController.maxPrice.value.toStringAsFixed(2)}'),
            Obx(() => Slider(
                  value: priceController.maxPrice.value,
                  min: 0.0,
                  max: 200.0,
                  divisions: 20,
                  label: '\$${priceController.maxPrice.value.round()}',
                  onChanged: (value) => priceController.updatePriceRange(
                    priceController.minPrice.value,
                    value,
                  ),
                )),
            SizedBox(height: 16),
            // Sorting Filter
            Obx(() {
              return DropdownButtonFormField<String>(
                value: locationController.sortBy.value,
                hint: Text('Sort By'),
                items: ['Price', 'Fill Percentage'].map((option) {
                  return DropdownMenuItem<String>(
                      value: option, child: Text(option));
                }).toList(),
                onChanged: (value) => locationController.sortBy.value = value!,
              );
            }),
            SizedBox(height: 16),
            // Apply Filters Button
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

// ContainerFillWidget remains the same

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
            color: Colors.white,
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
                Image.network(
                  imageUrl,
                  width: 300,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Container(
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
