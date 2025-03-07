import 'package:flutter/material.dart';
import 'package:my_bank/CardDetailPage.dart';

// Store all queries globally
List<Query> queryList = [];

class QueryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display a message if there are no queries
            if (queryList.isEmpty)
              Center(
                child: Text(
                  'No queries yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: queryList.length,
                  itemBuilder: (context, index) {
                    final query = queryList[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the CardDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardDetailPage(
                              title: query.title,
                              subtitle: query.subtitle,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1F2F9B), Color(0xFF4B6BFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                query.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Subtitle (Short description or key detail)
                              Text(
                                query.subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 12),
                              // Discussion type
                              Row(
                                children: [
                                  Icon(Icons.comment, color: Colors.white, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    query.discussion, // Display discussion type
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Brief details in row
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.white, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    query.usernameType,
                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                  SizedBox(width: 20),
                                  Icon(Icons.folder_open, color: Colors.white, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    query.sectionType,
                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Display files if available
                              if (query.files.isNotEmpty)
                                Row(
                                  children: [
                                    Icon(Icons.attach_file, color: Colors.white, size: 18),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        query.files.join(', '),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
