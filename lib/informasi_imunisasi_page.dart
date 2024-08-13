import 'package:flutter/material.dart';
import 'detail_vaksin.dart'; // Import the VaccineDetailPage

class InformasiImunisasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Imunisasi'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                'assets/images/imunisasi.jpg'), // Replace with your image path
            SizedBox(height: 16),
            Text(
              'Imunisasi adalah pemberian vaksin ke dalam tubuh seseorang untuk memberikan kekebalan terhadap penyakit tersebut. Berikut ini adalah 3 jenis imunisasi pada balita:',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VaccineDetailPage(
                            title: 'Hepatitis B',
                            imagePath:
                                'assets/images/hepatitis_b.jpg', // Replace with your image path
                            description:
                                'Vaksin Hepatitis B diberikan untuk mencegah infeksi virus hepatitis B yang dapat menyebabkan kerusakan hati.',
                          ),
                        ),
                      );
                    },
                    child: Text('Hepatitis B'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VaccineDetailPage(
                            title: 'Campak',
                            imagePath:
                                'assets/images/campak.jpg', // Replace with your image path
                            description:
                                'Vaksin Campak diberikan untuk mencegah penyakit campak yang dapat menyebabkan komplikasi serius.',
                          ),
                        ),
                      );
                    },
                    child: Text('Campak'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VaccineDetailPage(
                            title: 'Polio',
                            imagePath:
                                'assets/images/polio.jpg', // Replace with your image path
                            description:
                                'Vaksin Polio diberikan untuk mencegah penyakit polio yang dapat menyebabkan kelumpuhan.',
                          ),
                        ),
                      );
                    },
                    child: Text('Polio'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
