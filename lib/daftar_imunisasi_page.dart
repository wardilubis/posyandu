import 'package:flutter/material.dart';
import 'api_service.dart';
import 'tambah_imunisasi_page.dart'; // Import the TambahImunisasiPage

class DaftarImunisasiPage extends StatefulWidget {
  @override
  _DaftarImunisasiPageState createState() => _DaftarImunisasiPageState();
}

class _DaftarImunisasiPageState extends State<DaftarImunisasiPage> {
  late Future<List<dynamic>> _immunizations;

  @override
  void initState() {
    super.initState();
    _immunizations =
        ApiService.fetchImmunizations(); // Fetch all immunizations from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Imunisasi'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TambahImunisasiPage()),
              ).then((value) {
                if (value == true) {
                  // Refresh the list after adding a new record
                  setState(() {
                    _immunizations = ApiService.fetchImmunizations();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _immunizations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load immunizations: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No immunization records found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final immunization = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Bayi: ${immunization['nama_bayi']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Jenis Kelamin: ${immunization['jenis_kelamin']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tanggal Lahir: ${immunization['tanggal_lahir']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Usia: ${immunization['usia']} bulan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Berat Badan: ${immunization['berat_badan']} kg',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tinggi Bayi: ${immunization['tinggi_bayi']} cm',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
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
