import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:gkeep/service/appwrite_config.dart';
import 'package:appwrite/enums.dart';

class AuthService {
  final Account _account = AppwriteConfig.account;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Redirect URL (pastikan sesuai dengan callback di Appwrite dan Google)
      const redirectUrl =
          'https://cloud.appwrite.io/v1/account/sessions/oauth2/callback/github/677b8aa6000d4b609c1b';

      // Mulai sesi OAuth Google
      await _account.createOAuth2Session(
        provider: OAuthProvider.github,
        success: 'https://githu.com', // Sesuaikan jika menggunakan lokal
        failure: 'http://localhost:3000/auth',
      );

      // Notifikasi login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil!')),
      );
    } on AppwriteException catch (e) {
      // Tangkap error dari Appwrite
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: ${e.message}')),
      );
    } catch (e) {
      // Tangkap error lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }
}
