import 'package:flutter/material.dart';
import 'note_add_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<String> notes = []; // List to store the notes

  @override
  void initState() {
    super.initState();
    fetchNotes(); // Fetch existing notes when the page is loaded
  }

  Future<void> fetchNotes() async {
    // Fetch notes from your database (you will need to implement this)
    // This is a placeholder function, replace it with your implementation
  }

  Future<void> saveNote(String note) async {
    final response = await http.post(
      Uri.parse('http://192.168.27.18/KATSEYY/save_note.php'), // Update with your URL
      body: {
        'note': note,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        setState(() {
          notes.add(note); // Add the saved note to the list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'])),
        );
      }
    } else {
      print('Failed to save note.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purple Notepad - Notes'),
        backgroundColor: const Color(0xFF7965CE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: notes.isEmpty
                  ? const Center(child: Text('No notes available.'))
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color(0xFFD2C9E5),
                          child: ListTile(
                            title: Text(notes[index],
                                style: const TextStyle(
                                    fontSize: 18, color: Color(0xFF4A3B9D))),
                          ),
                        );
                      },
                    ),
            ),
            // Create Note Button
           ElevatedButton(
              onPressed: () async {
                // Navigate to Add Note page and wait for the result (saved note)
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteAddPage(), // Direct route
                  ),
                );
                if (result != null) {
                  setState(() {
                    notes.add(result as String); // Add the saved note to the list
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7965CE),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Create Note', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}