import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Saeed Notes', home: const NotesPage());
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() { super.initState(); _loadNote(); }
  _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() { _controller.text = prefs.getString('note') ?? ""; });
  }
  _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('note', _controller.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note Saved!')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saeed Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _controller, maxLines: 10, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Write note')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _saveNote, child: const Text('Save Note')),
        ]),
      ),
    );
  }
}
