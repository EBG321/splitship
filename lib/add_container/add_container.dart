import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContainerPage extends StatefulWidget {
  @override
  _AddContainerPageState createState() => _AddContainerPageState();
}

class _AddContainerPageState extends State<AddContainerPage> {
  final _formKey = GlobalKey<FormState>();
  final _dimensionsController = TextEditingController();
  final _priceController = TextEditingController();
  final _containerTypeController = TextEditingController();
  final _fillPercentageController = TextEditingController();
  final _shippingDateController = TextEditingController();

  String selectedContainerType = "dry container"; // Default container type
  String selectedLocation = "Afghanistan"; // Default location
  String imageUrl = ""; // Placeholder for image URL based on container type

  // Map of container types to image URLs
  final Map<String, String> containerImages = {
    "dry container": "https://www.shutterstock.com/image-illustration/3d-rendering-open-empty-red-600nw-1696470574.jpg",
    "Flat rack container": "https://s.alicdn.com/@sc04/kf/HTB1628mX5zxK1Rjy1zk761HrVXae.png_720x720q50.png",
    "Open top container": "https://www.boxman.co.nz/wp-content/uploads/2022/06/f_158_01_Boxman_20ft_open_top_container.jpg",
    "Double door container": "https://www.cascadecontainer.com/cdn/shop/files/40_STD_Double_Door_jpg.webp?v=1702774703",
    "ISO Reefer container": "https://s.alicdn.com/@sc04/kf/H51898bfdd42941a6b48afa4fedea05e1m.jpg_720x720q50.jpg",
  };

  // List of countries for location selection
  final List<String> countries = [
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
  // Function to set the image URL based on container type
  void _setContainerImage(String containerType) {
    setState(() {
      imageUrl = containerImages[containerType] ?? "";
    });
  }

  // Function to add container data to Firebase
  Future<void> _addContainer() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Set the image URL based on the selected container type
        final imageUrl = containerImages[selectedContainerType] ?? "";

        // Collect the container data from the form
        final containerData = {
          'container_type': selectedContainerType,
          'dimensions': _dimensionsController.text,
          'price': double.parse(_priceController.text),
          'location': selectedLocation,
          'fillPercentage': double.parse(_fillPercentageController.text) / 100,
          'shippingDate': _shippingDateController.text,
          'imageUrl': imageUrl, // Use the dynamically set image URL
        };

        // Add the container data to the containers collection and get the document ID
        final containerDocRef = await FirebaseFirestore.instance
            .collection('containers')
            .add(containerData);

        final containerID = containerDocRef.id;

        // Add the container ID to the user's document
        final userID = "BJW4FFPNTIT5hDy4c7g9HWxx5om2"; // Replace with dynamic user ID
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .update({
          'container': {'id': containerID},
        });

        Get.snackbar('Success', 'Container added successfully!');
        Navigator.pop(context);
      } catch (e) {
        Get.snackbar('Error', 'Failed to add container: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Container'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dimensionsController,
                decoration: InputDecoration(labelText: 'Dimensions'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the container dimensions';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fillPercentageController,
                decoration: InputDecoration(labelText: 'Fill Percentage'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fill percentage';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _shippingDateController,
                decoration: InputDecoration(labelText: 'Shipping Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the shipping date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedContainerType,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedContainerType = value;
                      _setContainerImage(value); // Set the image URL when the container type changes
                    });
                  }
                },
                items: containerImages.keys.map((containerType) {
                  return DropdownMenuItem<String>(
                    value: containerType,
                    child: Text(containerType),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Container Type'),
              ),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedLocation = value;
                    });
                  }
                },
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Location'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addContainer,
                child: Text('Add Container'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
