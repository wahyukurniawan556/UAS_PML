import 'package:flutter/material.dart';
import 'package:gkeep/models/notemodels.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(String) deleteNote;

  const NoteItem({super.key, required this.note, required this.deleteNote});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => deleteNote(note.id),
        ),
        onTap: () {
          // Handle note tap (e.g., to view or edit)
        },
      ),
    );
  }
}
