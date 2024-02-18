import 'package:flutter/material.dart';

class save extends StatelessWidget {
  final String password;

  save({required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Password'),
      ),
      body: Center(
        child: Text(
          'Generated Password: $password',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
