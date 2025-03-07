import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_bank/QueryListPage.dart';

class Query {
  final String title;
  final String subtitle;
  final String usernameType;
  final String discussion;
  final List<String> files;
  final String sectionType;
  final String incidentType;

  Query({
    required this.title,
    required this.subtitle,
    required this.usernameType,
    required this.discussion,
    required this.files,
    required this.sectionType,
    required this.incidentType,
  });
}

class CardDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  CardDetailPage({required this.title, required this.subtitle});

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  String? filePath;
  List<String> filePaths = [];
  TextEditingController usernameController = TextEditingController();
  TextEditingController discussionController = TextEditingController();

  // Function to pick multiple files
  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        filePaths = result.files.map((e) => e.path!).toList();
      });
    }
  }

  // Function to remove a file from the list
  void removeFile(int index) {
    setState(() {
      filePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${widget.title}', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Subtitle
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1F2F9B),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Username Type
            _buildTextField(
              controller: usernameController,
              label: 'Username Type',
              icon: Icons.person,
            ),

            SizedBox(height: 20),

            // Brief Discussion
            _buildTextField(
              controller: discussionController,
              label: 'Brief Discussion',
              icon: Icons.chat,
              maxLines: 3,
            ),

            SizedBox(height: 20),

            // Choose Files Button
            ElevatedButton(
              onPressed: pickFiles,
              child: Text('Choose Files', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),

            SizedBox(height: 20),

            // Display selected files
            if (filePaths.isNotEmpty) ...[
              Text('Selected Files:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filePaths.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(filePaths[index].split('/').last),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFile(index),
                      ),
                    ),
                  );
                },
              ),
            ],

            SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Collect the data and add it to global queryList
                final query = Query(
                  title: widget.title,
                  subtitle: widget.subtitle,
                  usernameType: usernameController.text,
                  discussion: discussionController.text,
                  files: filePaths,
                  sectionType: 'IT Incident',
                  incidentType: widget.title,
                );

                // Add query to global list
                queryList.add(query);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Query Submitted Successfully!')),
                );

                // Navigate back to the query list
                Navigator.pop(context);
              },
              child: Text('Submit', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method for creating text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(icon, color: Color(0xFF1F2F9B)),
        border: OutlineInputBorder(),
      ),
    );
  }
}
