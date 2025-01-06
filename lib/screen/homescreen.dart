import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:gkeep/models/notemodels.dart';
import 'package:gkeep/screen/drawingscreen.dart';
import 'package:gkeep/screen/note.dart';
import 'package:gkeep/sidebar/arsippage.dart';
import 'package:gkeep/sidebar/setting.dart';
import 'package:gkeep/sidebar/sampah.dart';
import 'package:gkeep/service/appwrite_service.dart';
import 'package:gkeep/service/appwrite_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppwriteNoteService noteService;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    noteService = AppwriteNoteService(
      databases: Databases(AppwriteConfig.client),
      databaseId:
          '677b8af70024db32a59d', // Ganti dengan database ID Appwrite Anda
      collectionId:
          '677b8b380012c197af88', // Ganti dengan collection ID Appwrite Anda
    );
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      final fetchedNotes = await noteService.getNotes();
      setState(() {
        notes = fetchedNotes
            .map((note) => note.toMap())
            .cast<Map<String, dynamic>>()
            .toList();
      });
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.lock, color: Colors.orange),
              SizedBox(width: 10),
              Text('Login'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Masuk'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Lupa kata sandi kamu?'),
              ),
              Divider(),
              ElevatedButton.icon(
                icon: Icon(Icons.account_circle),
                label: Text('Masuk dengan Google'),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Telusuri catatan Anda',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.grid_view, color: Colors.white54),
              onPressed: () {},
            ),
            GestureDetector(
              onTap: () => _showLoginDialog(context),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: GestureDetector(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 39, 39, 39),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 39, 39, 39),
                ),
                child: Text(
                  'Google Keep',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.lightbulb_outline, color: Colors.white),
                title: Text('Catatan', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.white),
                title: Text('Pengingat', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.label, color: Colors.white),
                title: Text('Buat label baru',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.archive, color: Colors.white),
                title: Text('Arsip', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageArsip()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.white),
                title: Text('Sampah', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SampahPage()),
                  );
                },
              ),
              Divider(color: Colors.grey[700]),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Setelan', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.white),
                title: Text('Bantuan & masukan',
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Catatan yang Anda tambahkan muncul di sini',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  color: Colors.grey[850],
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(
                      note['title'],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      note['content'],
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      DateTime.fromMillisecondsSinceEpoch(note['date'])
                          .toLocal()
                          .toString()
                          .split(' ')[0],
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotePage()),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(),
            ),
          ).then((_) => fetchNotes());
        },
      ),
    );
  }
}
