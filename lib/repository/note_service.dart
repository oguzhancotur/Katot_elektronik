import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NoteService {
  final firebaseStorageInstance =
      FirebaseStorage.instance; // Firebase Storage ile bağlantı yapıldı.
  final firebaseFirestoreInstance =
      FirebaseFirestore.instance; //firestore ile baglantı yapıldı.

  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String title, String content) async {
    await _notesCollection.add({'title': title, 'content': content});
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _notesCollection.doc(id).update({'title': title, 'content': content});
  }

  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final QuerySnapshot querySnapshot = await _notesCollection.get();
    final List<Map<String, dynamic>> notesList = [];

    querySnapshot.docs.forEach((doc) {
      notesList.add(doc.data() as Map<String, dynamic>);
    });

    return notesList;
  }
}
