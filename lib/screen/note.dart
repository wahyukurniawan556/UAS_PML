import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:gkeep/appwrite_client.dart';
import 'package:gkeep/service/appwrite_config.dart';
import 'package:gkeep/sidebar/sampah.dart'; // Pastikan path sesuai

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final Databases _databases = Databases(AppwriteConfig.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Tambahkan aksi untuk notifikasi
            },
          ),
          IconButton(
            icon: Icon(Icons.push_pin),
            onPressed: () {
              // Tambahkan aksi untuk pin
            },
          ),
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              // Tambahkan aksi untuk arsip
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Judul",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: noteController,
              style: TextStyle(color: Colors.white, fontSize: 16),
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Catatan",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: () async {
          final title = titleController.text.trim();
          final content = noteController.text.trim();

          if (title.isNotEmpty || content.isNotEmpty) {
            try {
              // Ganti dengan ID database dan koleksi Anda
              const databaseId = '677b8af70024db32a59d';
              const collectionId = '677b8b380012c197af88';

              final response = await _databases.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId:
                    'unique()', // Gunakan 'unique()' untuk ID unik otomatis
                data: {
                  'title': title,
                  'content': content,
                  'date': DateTime.now().millisecondsSinceEpoch,
                },
              );

              print('Note saved: ${response.$id}');
              Navigator.pop(context, true); // Kembali ke halaman sebelumnya
            } catch (e) {
              print('Error saving note: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal menyimpan catatan')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Judul atau catatan tidak boleh kosong')),
            );
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
