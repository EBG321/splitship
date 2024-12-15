import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var fromLocation = 'India'.obs; // Default value
  var toLocation = 'United States'.obs; // Default value
  var sortBy = 'Price'.obs; // New observable for sorting
  var selectedContainerType = ''.obs;
  var maxPrice = 2000.0.obs;  // Max price for filtering
  var minPrice = 0.0.obs;    // Min price for filtering

  List<String> locations = [
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia",
    "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
    "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi",
    "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros",
    "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo",
    "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea",
    "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece",
    "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia",
    "Iran", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati",
    "Korea, North", "Korea, South", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein",
    "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania",
    "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia",
    "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan",
    "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia",
    "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe",
    "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands",
    "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan",
    "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
    "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu",
    "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
  ];

  List<String> containerTypes = [
    'dry container',
    'Flat rack container',
    'Open top container',
    'Double door container',
    'ISO Reefer container'
  ];

  // Function to update price range
  void updatePriceRange(double min, double max) {
    minPrice.value = min;  // Set the minimum price
    maxPrice.value = max;  // Set the maximum price
  }


  void setContainerType(String? type) {
    if (type != null) {
      selectedContainerType.value = type;
    }
  }
  void setFromLocation(String? newValue) {
    fromLocation.value = newValue ?? '';
    fetchAndSetContainers();
  }

  void setToLocation(String? newValue) {
    toLocation.value = newValue ?? '';
    fetchAndSetContainers();
  }


  void setMaxPrice(double price) => maxPrice.value = price;

  /// Fetch filtered containers based on selected filters.
  Future<List<Map<String, dynamic>>> fetchContainersByCountry(String country) async {
    try {
      print('Fetching containers for country: $country');

      // Fetch containers matching the location
      final snapshot = await FirebaseFirestore.instance
          .collection('containers')
          .where('location', isEqualTo: country)
          .get();

      // Convert Firestore documents to a list of maps
      List<Map<String, dynamic>> containers = snapshot.docs.map((doc) {
        return {
          'imageUrl': doc['imageUrl'] ?? '',
          'fillPercentage': doc['fillPercentage'] ?? 0.0,
          'container_type': doc['container_type'] ?? '',
          'dimensions': doc['dimensions'] ?? '',
          'price': doc['price'] ?? 0.0,
          'shippingDate': doc['shippingDate'] ?? '',
        };
      }).toList();

      print('Initial containers fetched: ${containers.length}');

      // Apply price filtering
      containers = containers.where((container) {
        double price = container['price'] ?? 0.0;
        return price >= minPrice.value && price <= maxPrice.value;
      }).toList();
      print('After price filtering: ${containers.length}');

      // Apply container type filtering
      if (selectedContainerType.value.isNotEmpty) {
        containers = containers.where((container) {
          return container['container_type'] == selectedContainerType.value;
        }).toList();
      }
      print('After container type filtering: ${containers.length}');

      // Apply sorting
      if (sortBy.value == 'Fill Percentage') {
        containers.sort((a, b) {
          return (a['fillPercentage'] ?? 0.0).compareTo(b['fillPercentage'] ?? 0.0);
        });
      } else if (sortBy.value == 'Price') {
        containers.sort((a, b) {
          return (a['price'] ?? 0.0).compareTo(b['price'] ?? 0.0);
        });
      }
      print('After sorting: ${containers.length}');

      return containers; // Return the filtered and sorted list
    } catch (e) {
      print('Error fetching containers: $e');
      return []; // Return an empty list in case of error
    }
  }


  var containers = <Map<String, dynamic>>[].obs;

  void fetchAndSetContainers() async {
    if (fromLocation.value.isEmpty || toLocation.value.isEmpty) {
      containers.clear(); // Clear if locations are not set
      return;
    }
    try {
      final result = await fetchContainersByCountry(fromLocation.value);
      containers.value = result; // Update the reactive list
    } catch (e) {
      print('Error fetching containers: $e');
      containers.clear(); // Clear the list on error
    }
  }






}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class LocationController extends GetxController {
//   var fromLocation = 'India'.obs; // Default value
//   var toLocation = 'United States'.obs; // Default value
//   var sortBy = 'Price'.obs; // New observable for sorting
//   var selectedContainerType = ''.obs;
//   var maxPrice = 2000.0.obs;  // Max price for filtering
//   var minPrice = 0.0.obs;    // Min price for filtering
//
//   List<String> locations = [
//     "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia",
//     "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
//     "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi",
//     "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros",
//     "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo",
//     "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea",
//     "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece",
//     "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia",
//     "Iran", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati",
//     "Korea, North", "Korea, South", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein",
//     "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania",
//     "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia",
//     "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan",
//     "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia",
//     "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe",
//     "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands",
//     "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan",
//     "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
//     "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu",
//     "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
//   ];
//
//   List<String> containerTypes = [
//     'dry container',
//     'Flat rack container',
//     'Open top container',
//     'Double door container',
//     'ISO Reefer container'
//   ];
//
//   // Function to update price range
//   void updatePriceRange(double min, double max) {
//     minPrice.value = min;  // Set the minimum price
//     maxPrice.value = max;  // Set the maximum price
//   }
//
//
//   void setContainerType(String? type) {
//     if (type != null) {
//       selectedContainerType.value = type;
//     }
//   }
//   void setFromLocation(String? newValue) {
//     fromLocation.value = newValue ?? '';
//     fetchAndSetContainers();
//   }
//
//   void setToLocation(String? newValue) {
//     toLocation.value = newValue ?? '';
//     fetchAndSetContainers();
//   }
//
//
//   void setMaxPrice(double price) => maxPrice.value = price;
//
//   /// Fetch filtered containers based on selected filters.
//   Future<List<Map<String, dynamic>>> fetchContainersByCountry(String country) async {
//     try {
//       print('Fetching containers for country: $country');
//
//       // Fetch containers matching the location
//       final snapshot = await FirebaseFirestore.instance
//           .collection('containers')
//           .where('location', isEqualTo: country)
//           .get();
//
//       // Convert Firestore documents to a list of maps
//       List<Map<String, dynamic>> containers = snapshot.docs.map((doc) {
//         return {
//           'imageUrl': doc['imageUrl'] ?? '',
//           'fillPercentage': doc['fillPercentage'] ?? 0.0,
//           'container_type': doc['container_type'] ?? '',
//           'dimensions': doc['dimensions'] ?? '',
//           'price': doc['price'] ?? 0.0,
//           'shippingDate': doc['shippingDate'] ?? '',
//         };
//       }).toList();
//
//       print('Initial containers fetched: ${containers.length}');
//
//       // Apply price filtering
//       containers = containers.where((container) {
//         double price = container['price'] ?? 0.0;
//         return price >= minPrice.value && price <= maxPrice.value;
//       }).toList();
//       print('After price filtering: ${containers.length}');
//
//       // Apply container type filtering
//       if (selectedContainerType.value.isNotEmpty) {
//         containers = containers.where((container) {
//           return container['container_type'] == selectedContainerType.value;
//         }).toList();
//       }
//       print('After container type filtering: ${containers.length}');
//
//       // Apply sorting
//       if (sortBy.value == 'Fill Percentage') {
//         containers.sort((a, b) {
//           return (a['fillPercentage'] ?? 0.0).compareTo(b['fillPercentage'] ?? 0.0);
//         });
//       } else if (sortBy.value == 'Price') {
//         containers.sort((a, b) {
//           return (a['price'] ?? 0.0).compareTo(b['price'] ?? 0.0);
//         });
//       }
//       print('After sorting: ${containers.length}');
//
//       return containers; // Return the filtered and sorted list
//     } catch (e) {
//       print('Error fetching containers: $e');
//       return []; // Return an empty list in case of error
//     }
//   }
//
//
//   var containers = <Map<String, dynamic>>[].obs;
//
//   void fetchAndSetContainers() async {
//     if (fromLocation.value.isEmpty || toLocation.value.isEmpty) {
//       containers.clear(); // Clear if locations are not set
//       return;
//     }
//     try {
//       final result = await fetchContainersByCountry(fromLocation.value);
//       containers.value = result; // Update the reactive list
//     } catch (e) {
//       print('Error fetching containers: $e');
//       containers.clear(); // Clear the list on error
//     }
//   }
//
//
//
//
//
//
// }
