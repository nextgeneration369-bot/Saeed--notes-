import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() { runApp(const MyApp()); }
class MyApp extends StatelessWidget { const MyApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(title: 'Saeed Notes', home: const NotesPage(), debugShowCheckedModeBanner: false);
  }
}
class NotesPage extends StatefulWidget { const NotesPage({super.key}); @override State<NotesPage> createState() => _NotesPageState(); }
class _NotesPageState extends State<NotesPage> {
  List<String> _notes = []; final TextEditingController _controller = TextEditingController();
  @override void initState() { super.initState(); _loadNotes(); }
  _loadNotes() async { SharedPreferences prefs = await SharedPreferences.getInstance(); setState(() { _notes = prefs.getStringList('notes')?? []; }); }
  _saveNotes() async { SharedPreferences prefs = await SharedPreferences.getInstance(); prefs.setStringList('notes', _notes); }
  _addNote() { if (_controller.text.isNotEmpty) { setState(() { _notes.add(_controller.text); _controller.clear(); }); _saveNotes(); } }
  _deleteNote(int index) { setState(() { _notes.removeAt(index); }); _saveNotes(); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Saeed Notes')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [
          Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Write a note...', border: OutlineInputBorder()))),
          const SizedBox(width: 10), ElevatedButton(onPressed: _addNote, child: const Text('Add')),
        ])),
        Expanded(child: ListView.builder(itemCount: _notes.length, itemBuilder: (context, index) {
          return ListTile(title: Text(_notes[index]), trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteNote(index)));
        })),
      ]),
    );
  }
}
