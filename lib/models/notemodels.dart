// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // Factory method to create Note from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['\$id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  // Convert Note to Map
  Map<String, dynamic> toMap() {
    return {
      '\$id': id,
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
    };
  }
}
