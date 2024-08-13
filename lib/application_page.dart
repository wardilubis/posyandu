import 'package:flutter/material.dart';
import 'open_ticket_page.dart';
import 'schedule_page.dart';
import 'galeri_page.dart';
import 'profile_page.dart';
import 'daftar_balita_page.dart';
import 'daftar_imunisasi_page.dart';
import 'informasi_imunisasi_page.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    SchedulePage(),
    GaleriPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button
        title: Text('Posyandu Cinta Kasih 2'), // Update the title text
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Notifikasi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), label: 'Galeri'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Handle filter action
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3, // 3 icons per row
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CategoryButton(
                  icon: Icons.photo,
                  label: 'Galeri',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GaleriPage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.local_hospital,
                  label: 'Posyandu',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.vaccines,
                  label: 'Imunisasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DaftarImunisasiPage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.child_care,
                  label: 'Data Balita',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DaftarBalitaPage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.info,
                  label: 'Informasi Imunisasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformasiImunisasiPage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.notifications,
                  label: 'Notifikasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SchedulePage()),
                    );
                  },
                ),
                CategoryButton(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () async {
                    // Implement logout functionality here
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Buat tiket kunjungan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpenTicketPage()),
                );
              },
              child: AppointmentCard(),
            ),
            SizedBox(height: 16),
            Text(
              'Pengumuman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            AnnouncementCard(
              imageUrl:
                  'https://ahligizi.id/blog/wp-content/uploads/2021/04/sedang_1583992455_PSOYANDU.jpg', // Replace with your image URL
              heading: 'Pengumuman 1',
              description: 'Deskripsi pengumuman 1.',
            ),
            AnnouncementCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Replace with your image URL
              heading: 'Pengumuman 2',
              description: 'Deskripsi pengumuman 2.',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  CategoryButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pinkAccent.withOpacity(0.1),
            child: Icon(icon, size: 30, color: Colors.pink),
          ),
          SizedBox(height: 8),
          Center(
            // Center the text label
            child: Text(
              label,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center, // Ensures the text is center-aligned
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.pinkAccent.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Open Ticket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.add_circle,
              color: Colors.pink,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String imageUrl;
  final String heading;
  final String description;

  AnnouncementCard(
      {required this.imageUrl,
      required this.heading,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl,
                height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
