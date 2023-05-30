
import 'package:firebase_database/firebase_database.dart';

class NoteService {

  void listAllNote(){
    DatabaseReference ref = FirebaseDatabase.instance.ref('notes');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      data
    });
  }

  Future<void> saveNote(String title, String description){
    DatabaseReference ref = FirebaseDatabase.instance.ref("notes");
    final Map<String, dynamic> data = {
      "title": title,
      "description": description
    };
    return ref.set(data);
  }

  Future<void> updateNote(int noteId, String title, String description) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("notes/$noteId");
    final Map<String, dynamic> updates = {
      "title": title,
      "description": description
    };
    return ref.update(updates);
  }

  Future<void> deleteNote(int noteId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('notes/$noteId').get();
    if (snapshot.exists) {
      print(snapshot.value);
      final note = ref.child(snapshot.key!);
      return note.remove();
    } else {
      print('No data available.');
    }
  }

}