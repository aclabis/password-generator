import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passgenerator/save_pass.dart';

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final TextEditingController _lengthController = TextEditingController();
  String _generatedPassword = '';

  void _generatePassword() {
    final length = int.tryParse(_lengthController.text) ?? 12;
    final random = Random.secure();
    final chars = List.generate(length, (_) {
      final specialChars = "!@#%^&*()_+-=[]{}|;:,.<>?";
      final allChars =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$specialChars";
      return allChars[random.nextInt(allChars.length)];
    });
    setState(() {
      _generatedPassword = chars.join();
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _lengthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Password Length',
                  hintText: 'Enter the length of the password',
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onLongPress: _generatedPassword.isNotEmpty
                    ? _copyToClipboard
                    : null, // kei teha pass bhaye copy garcha natra null
                child: Container(
                  height: 50,
                  width: 360,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(13)),
                  child: _generatedPassword.isNotEmpty
                      ? SelectableText(
                          _generatedPassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        )
                      : SizedBox(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _generatePassword();
                },
                child: Text('Generate Password'),
              ),
              SizedBox(height: 5.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => SavePass(generatedPassword:_generatedPassword ,)));
                  },
                  child: Text("Want to save password")),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Note :",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 3, 123, 221)),
                    ),
                    Text(
                        " -  Generate password according to how much length you want !",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    Text(" -  Copy the generated password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    Text(
                        " -  To save password, tap on button name (lets save password)",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    Text(" -  Enter the name of media.",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    Text(" -  Paste the previous copied password. ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    Text(" -  Then tap the save buton to save password.",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
