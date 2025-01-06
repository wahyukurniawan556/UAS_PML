import 'package:flutter/material.dart';

class SampahPage extends StatelessWidget {
  final List<Map<String, String>> trashNotes = [
    {
      'title': 'Uffh',
      'image': 'assets/images/sample_image.jpg', // Ganti dengan path gambar
    },
  ];

  SampahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
        title: Text('Sampah', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Tambahkan aksi jika diperlukan
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Catatan dalam Sampah akan dihapus setelah 7 hari',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: trashNotes.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada catatan di sampah',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: trashNotes.length,
                    itemBuilder: (context, index) {
                      final note = trashNotes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          color: Colors.grey[900],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (note['image'] != null)
                                Image.asset(
                                  note['image']!,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  note['title'] ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Tambahkan logika hapus catatan
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
