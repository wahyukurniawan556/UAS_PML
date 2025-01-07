import 'package:appwrite/enums.dart';
import 'package:flutter/material.dart';
import '../service/appwrite_config.dart'; // Sesuaikan path file konfigurasi Anda

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? userName; // Menyimpan nama pengguna
  String? userEmail; // Menyimpan email pengguna
  String? userPhoto; // Menyimpan foto pengguna
  bool isLoading = false; // Status loading

  @override
  void initState() {
    super.initState();
    checkCurrentSession();
  }

  // Cek sesi pengguna saat ini
  Future<void> checkCurrentSession() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await AppwriteConfig.account.get();
      final userMap = user.toMap();
      setState(() {
        userName = userMap['name'];
        userEmail = userMap['email'];
        userPhoto = userMap['prefs'] != null
            ? userMap['prefs']['avatar']
            : null; // Sesuaikan dengan atribut prefs
      });
    } catch (e) {
      print('Tidak ada sesi aktif: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Login dengan GitHub
  Future<void> loginWithGitHub() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AppwriteConfig.account
          .createOAuth2Session(provider: OAuthProvider.github);
      await checkCurrentSession();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login berhasil')));
    } catch (e) {
      print('Login gagal: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login gagal')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Logout
  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AppwriteConfig.account.deleteSession(sessionId: 'current');
      setState(() {
        userName = null;
        userEmail = null;
        userPhoto = null;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logout berhasil')));
    } catch (e) {
      print('Logout gagal: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logout gagal')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : userName != null
                ? ProfileWidget(
                    userName: userName!,
                    userEmail: userEmail!,
                    userPhoto: userPhoto,
                    onLogout: logout,
                  )
                : Center(
                    child: ElevatedButton.icon(
                      onPressed: loginWithGitHub,
                      icon: Icon(Icons.login),
                      label: Text('Login with GitHub'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? userPhoto;
  final VoidCallback onLogout;

  const ProfileWidget({
    Key? key,
    required this.userName,
    required this.userEmail,
    this.userPhoto,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    userPhoto != null ? NetworkImage(userPhoto!) : null,
                backgroundColor: Colors.teal,
                child: userPhoto == null
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                    : null,
              ),
              SizedBox(height: 16),
              Text(
                'Welcome, $userName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onLogout,
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
