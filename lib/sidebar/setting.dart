import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setelan'),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('OPSI TAMPILAN'),
          _buildSwitchTile(
            title: 'Menambahkan item baru ke bagian bawah',
            value: true,
            onChanged: (bool value) {},
          ),
          _buildSwitchTile(
            title: 'Pindahkan item yang dicentang ke bagian bawah',
            value: true,
            onChanged: (bool value) {},
          ),
          _buildSwitchTile(
            title: 'Menampilkan pratinjau link kaya',
            value: true,
            onChanged: (bool value) {},
          ),
          SizedBox(height: 24.0),
          _buildSectionTitle('SETELAN DEFAULT PENGINGAT'),
          _buildTimeTile(title: 'Pagi', time: '08.00'),
          _buildTimeTile(title: 'Siang/sore', time: '13.00'),
          _buildTimeTile(title: 'Petang', time: '18.00'),
          SizedBox(height: 24.0),
          _buildSectionTitle('BERBAGI'),
          _buildSwitchTile(
            title: 'Aktifkan berbagi',
            value: true,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
      tileColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildTimeTile({
    required String title,
    required String time,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      trailing: Text(
        time,
        style: TextStyle(fontSize: 16.0, color: Colors.white70),
      ),
      tileColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
