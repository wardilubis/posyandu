import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';
import 'tambah_balita_page.dart'; // Import the TambahBalitaPage

class DaftarBalitaPage extends StatefulWidget {
  @override
  _DaftarBalitaPageState createState() => _DaftarBalitaPageState();
}

class _DaftarBalitaPageState extends State<DaftarBalitaPage> {
  late Future<List<dynamic>> _babies;

  @override
  void initState() {
    super.initState();
    _babies = ApiService.fetchBabies(); // Fetch all babies from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Balita'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TambahBalitaPage()), // Navigate to TambahBalitaPage
              ).then((value) {
                if (value == true) {
                  // Refresh the list after adding a new baby
                  setState(() {
                    _babies = ApiService.fetchBabies();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _babies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load babies: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No babies found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final baby = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          baby['jenis_kelamin'] == 'Laki-laki'
                              ? Icons.male
                              : Icons.female,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                baby['nama'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Jenis Kelamin: ${baby['jenis_kelamin']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Tanggal Lahir: ${DateFormat('dd MMM yyyy').format(DateTime.parse(baby['tanggal_lahir']))}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.pinkAccent.withOpacity(0.3),
                          child: Text(
                            baby['nama'][0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
