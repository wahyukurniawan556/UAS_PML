import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'appwrite_config.dart';

class AuthService {
  final Account _account = Account(AppwriteConfig.client);

  // Login dengan Google
  Future<Session?> loginWithGoogle() async {
    try {
      final session = await _account.createOAuth2Session(
        provider: AppwriteConfig.googleProvider,
      );
      return session;
    } catch (e) {
      print('Login with Google failed: $e');
      return null;
    }
  }

  // Login sebagai Guest
  Future<User?> loginAsGuest() async {
    try {
      final user = await _account.createAnonymousSession();
      return user;
    } catch (e) {
      print('Guest login failed: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}
