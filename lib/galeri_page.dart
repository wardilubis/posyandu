import 'package:flutter/material.dart';

class GaleriPage extends StatelessWidget {
  final List<Map<String, String>> _images = [
    {
      'path': 'assets/images/img1.jpeg',
      'caption': 'Pemeriksaan kesehatan bayi'
    },
    {
      'path': 'assets/images/img2.jpeg',
      'caption': 'pemeriksaan berat badan sehat'
    },
    {
      'path': 'assets/images/img3.jpeg',
      'caption': 'Pemeriksaan kesehatan anak'
    },
    {'path': 'assets/images/img4.jpeg', 'caption': 'Imunisasi bayi'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          return GridTile(
            child: Image.asset(image['path']!, fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(image['caption']!, textAlign: TextAlign.center),
            ),
          );
        },
      ),
    );
  }
}
