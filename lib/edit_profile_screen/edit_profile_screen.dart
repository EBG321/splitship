import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart'; // Image Picker Web plugin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _imageBytes;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Pick an image from gallery (using image_picker_web for web)
  Future<void> _pickImage() async {
    // Use the image_picker_web package to pick an image in a web environment
    final result = await ImagePickerWeb.getImageAsBytes();
    if (result != null) {
      setState(() {
        _imageBytes = result;
      });
    } else {
      print("No image selected.");
    }
  }

  // Save the profile details
  void _saveProfile() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    print("Name: $name, Email: $email, Phone: $phone");

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully!")));
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = "John Doe";
    _emailController.text = "john.doe@example.com";
    _phoneController.text = "+1234567890";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 0, 45, 83),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!) // Use MemoryImage to display bytes from blob
                          : AssetImage('assets/profile.jpg') as ImageProvider,
                      child: _imageBytes == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Full Name", filled: true),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email", filled: true),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: "Phone Number", filled: true),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text("Save Changes", style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
