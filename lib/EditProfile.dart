import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController(text: "John Doe");
  final _emailController = TextEditingController(text: "john.doe@example.com");
  final _phoneController = TextEditingController(text: "+123456789");
  final _addressController = TextEditingController(text: "123 Street, City, Country");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 20),
              buildTextField("Name", _nameController),
              buildTextField("Email", _emailController),
              buildTextField("Phone", _phoneController),
              buildTextField("Address", _addressController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save profile updates here
                  // You can also add functionality to handle profile saving logic
                  Navigator.pop(context); // Go back to the profile page after saving
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F2F9B),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
