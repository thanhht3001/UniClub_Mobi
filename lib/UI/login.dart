import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/google_login_svc/google_login.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                  ),
                  Text('Login'),
                ],
              ),
              onPressed: () {
                final provider = GoogleLoginProvider();
                provider.GoogleLogin();
              },
            ),
          ],
        ),
      ),
    );
  }
}
