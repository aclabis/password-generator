import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePass extends StatefulWidget {
  final String generatedPassword;

  const SavePass({Key? key, required this.generatedPassword}) : super(key: key);

  @override
  State<SavePass> createState() => _SavePassState();
}

class _SavePassState extends State<SavePass> {
  final TextEditingController _mediaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _savePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('generated_password', widget.generatedPassword);
   
    prefs.setString('media_name', _mediaController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Save Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _mediaController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                labelText: 'For which media',
                hintText: "Enter the media name",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                labelText: 'Paste Password',
                hintText: "Paste the generated password",
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _savePassword,
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
