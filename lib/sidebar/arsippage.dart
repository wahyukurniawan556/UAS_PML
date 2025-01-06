import 'package:flutter/material.dart';

class PageArsip extends StatelessWidget {
  const PageArsip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text(
          'Arsip',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Tambahkan logika untuk pencarian
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.white),
            onPressed: () {
              // Tambahkan logika untuk grid view
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.archive,
              size: 100,
              color: Colors.white70,
            ),
            SizedBox(height: 20),
            Text(
              'Catatan Anda yang diarsipkan muncul di sini',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
