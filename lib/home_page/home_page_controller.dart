import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var fromLocation = ''.obs;
  var toLocation = ''.obs;
  var sortBy = 'Price'.obs; // New observable for sorting
  var selectedContainerType = ''.obs;
  var maxPrice = 200.0.obs; // Default max price

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

  void setFromLocation(String? newValue) {
    fromLocation.value = newValue ?? 'China';
  }

  void setToLocation(String? newValue) {
    toLocation.value = newValue ?? 'United States';
  }

  void setContainerType(String? type) {
    if (type != null) {
      selectedContainerType.value = type;
    }
  }

  void setMaxPrice(double price) => maxPrice.value = price;

  /// Fetch filtered containers based on selected filters.
  Future<List<Map<String, dynamic>>> fetchContainersByCountry(String country) async {
    try {
      // Query Firestore to get containers where 'location' matches the given country
      final snapshot = await FirebaseFirestore.instance
          .collection('containers') // Collection name is 'containers'
          .where('location', isEqualTo: country) // Filtering by country (location field)
          .get();

      // Map the query results into a list of maps
      return snapshot.docs.map((doc) {
        return {
          'imageUrl': doc['imageUrl'],
          'fillPercentage': doc['fillPercentage'],
          'container_type': doc['container_type'],
          'dimensions': doc['dimensions'],
          'price': doc['price'],
          'shippingDate': doc['shippingDate'],
        };
      }).toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }


}
