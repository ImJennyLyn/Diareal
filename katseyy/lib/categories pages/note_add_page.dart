import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({super.key});

  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  final TextEditingController _noteController = TextEditingController();

  Future<void> saveNoteToDatabase(String note) async {
    final response = await http.post(
      Uri.parse('http://192.168.27.18/KATSEYY/save_note.php'), // Replace with your PHP URL
      body: {
        'note': note,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        // Note saved successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'])),
        );
        Navigator.pop(context, note); // Return the saved note to the previous page
      } else {
        // Show error message from the server
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'])),
        );
      }
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save note.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: const Color(0xFF7965CE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E1F9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _noteController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Type your note here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_noteController.text.isNotEmpty) {
                  saveNoteToDatabase(_noteController.text); // Call the function to save note
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note cannot be empty.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7965CE),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Note', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
