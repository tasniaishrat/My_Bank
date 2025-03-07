import 'package:flutter/material.dart';
import 'package:my_bank/CardDetailPage.dart';
import 'package:my_bank/Profile.dart';
import 'package:my_bank/QueryListPage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track selected tab
  String searchQuery = ""; // Store search input

  // Function to get greeting based on time
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon';
    } else if (hour >= 16 && hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  // IT Incident List
  final List<Map<String, dynamic>> itIncidents = [
    {
      "title": "System Crash",
      "subtitle": "When the computer or application stops working unexpectedly.",
      "icon": Icons.warning_amber_rounded
    },
    {
      "title": "Network Issue",
      "subtitle": "Connectivity problems, like not being able to access the internet or a particular network.",
      "icon": Icons.wifi_off
    },
    {
      "title": "Application Failure",
      "subtitle": "When a specific application or software crashes or doesn't function as expected.",
      "icon": Icons.app_blocking
    },
    {
      "title": "Hardware Failure",
      "subtitle": "Issues with hardware like a broken keyboard, mouse, or monitor.",
      "icon": Icons.memory
    },
    {
      "title": "Software Bugs",
      "subtitle": " Problems with a program behaving unexpectedly or incorrectly.",
      "icon": Icons.bug_report
    },
    {
      "title": "Access Issues",
      "subtitle": " Problems logging in or accessing specific files or applications.",
      "icon": Icons.lock
    },
    {
      "title": "Security Breach",
      "subtitle": "Incidents like suspicious login attempts or security vulnerabilities.",
      "icon": Icons.security
    },
  ];

  // IT Services List
  // IT Services List
  // IT Services List with default subtitle handling
  final List<Map<String, dynamic>> itServices = [
    {
      "title": "Desktop/Laptop Service",
      "subtitle": "Issues related to computer hardware or software.", // Ensure this is always a string
      "icon": Icons.computer
    },
    {
      "title": "Email Related Service",
      "subtitle": "Requests like email setup, troubleshooting, or access issues.",
      "icon": Icons.email
    },
    {
      "title": "File Server",
      "subtitle": "Requests for shared file access or troubleshooting server issues.",
      "icon": Icons.folder
    },
    {
      "title": "User Administration",
      "subtitle": "Creating, modifying, or disabling user accounts.",
      "icon": Icons.people
    },
    {
      "title": "In-house Application Service",
      "subtitle": "Issues or requests related to internal company applications.",
      "icon": Icons.app_shortcut
    },
    {
      "title": "Network Service",
      "subtitle": "Connectivity issues, VPN access, or network configuration.",
      "icon": Icons.network_check
    },
  ];



  // Function to filter items based on search
  List<Map<String, dynamic>> getFilteredItems() {
    List<Map<String, dynamic>> originalList =
    _selectedIndex == 0 ? itIncidents : itServices;
    if (searchQuery.isEmpty) return originalList;

    return originalList
        .where((item) =>
        item["title"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  // Handle Bottom Navigation Tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      searchQuery = ""; // Reset search when switching tabs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with Logo
      appBar: AppBar(
        title: Image.asset(
          'assets/bank_logo.png',
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Left-side Drawer Menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1F2F9B),
              ),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Services'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder:(context)=>Profile()),
                );
              },
            ),
            ListTile(
              title: Text('Query'),
              leading: Icon(Icons.list_alt),
                 onTap: () {
                   Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => QueryListPage()), // Replace NextPage with your target page
                      );

              },
            ),
          ],
        ),
      ),

      // Scrollable Content
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Greeting Message Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '"Welcome to My Bank, your trusted provider!"',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        getGreeting(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2F9B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search IT Incidents / IT Services',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Display Filtered Results
              _buildFilteredList(),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar with Gradient Background
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F2F9B), Color(0xFF4B6BFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.report_problem), label: 'IT Incident'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'IT Service'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
        ),
      ),
    );
  }

  // Widget to display filtered results
  // Widget to display filtered results
  Widget _buildFilteredList() {
    List<Map<String, dynamic>> filteredItems = getFilteredItems();

    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }

    return Column(
      children: filteredItems.map((item) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(item["icon"], color: Color(0xFF1F2F9B), size: 30),
            title: Text(
              item["title"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              item["subtitle"] ?? "No subtitle available", // Fallback if subtitle is null
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailPage(
                    title: item["title"] ?? "No Title", // Fallback if title is null
                    subtitle: item["subtitle"] ?? "No subtitle available", // Fallback if subtitle is null
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

}
