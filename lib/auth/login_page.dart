import 'package:flutter/material.dart';
import 'package:gkeep/service/auth_service.dart';

class AuthPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appwrite Auth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final session = await _authService.loginWithGoogle();
                if (session != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login with Google Success')),
                  );
                }
              },
              child: Text('Login with Google'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = await _authService.loginAsGuest();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Guest Login Success')),
                  );
                }
              },
              child: Text('Login as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}
