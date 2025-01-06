import 'package:appwrite/appwrite.dart';
import 'package:gkeep/models/notemodels.dart';

class AppwriteNoteService {
  final Databases databases;
  final String databaseId;
  final String collectionId;

  AppwriteNoteService({
    required this.databases,
    required this.databaseId,
    required this.collectionId,
  });

  // Create a new note
  Future<Note> createNote({
    required String title,
    required String content,
    required DateTime date,
  }) async {
    final response = await databases.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: {
        'title': title,
        'content': content,
        'date': date.millisecondsSinceEpoch,
      },
    );

    return Note.fromMap(response.data);
  }

  // Get all notes
  Future<List<Note>> getNotes() async {
    final response = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
    );

    return response.documents.map((doc) => Note.fromMap(doc.data)).toList();
  }

  // Update an existing note
  Future<Note> updateNote({
    required String id,
    required String title,
    required String content,
    required DateTime date,
  }) async {
    final response = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: id,
      data: {
        'title': title,
        'content': content,
        'date': date.millisecondsSinceEpoch,
      },
    );

    return Note.fromMap(response.data);
  }

  // Delete a note
  Future<void> deleteNote({
    required String id,
  }) async {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: id,
    );
  }
}
