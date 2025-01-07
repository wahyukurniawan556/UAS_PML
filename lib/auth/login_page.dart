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
      setState(() {
        userName = user.name;
        userEmail = user.email;
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
  Future<void> loginWithGitHub(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await AppwriteConfig.account
          .createOAuth2Session(provider: OAuthProvider.github);
      await checkCurrentSession();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login berhasil')));
      Navigator.pop(context); // Tutup dialog setelah login berhasil
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

  void showLoginDialog(BuildContext context) {
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
                label: Text('Masuk dengan GitHub'),
                onPressed: () => loginWithGitHub(context),
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
      appBar: AppBar(title: Text('Login Page')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userName != null
              ? ProfileWidget(
                  userName: userName!,
                  userEmail: userEmail!,
                  onLogout: logout,
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () => showLoginDialog(context),
                    child: Text('Login'),
                  ),
                ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onLogout;

  const ProfileWidget({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome, $userName', style: TextStyle(fontSize: 20)),
        SizedBox(height: 8),
        Text(userEmail, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: onLogout,
          child: Text('Logout'),
        ),
      ],
    );
  }
}
