import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saeed Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _controller = TextEditingController();
  String _savedNote = "";

  @override
  void initState() {
    super.initState();
    _loadNote(); // Load saved note when app starts
  }

  // Load note from phone storage
  _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedNote = prefs.getString('note') ?? "";
      _controller.text = _savedNote;
    });
  }

  // Save note to phone storage
  _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('note', _controller.text);
    setState(() {
      _savedNote = _controller.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note Saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saeed Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write your note here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
