abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String content;
  AddNote({
    required this.title,
    required this.content,
  });
}

class UpdateNote extends NoteEvent {
  final String id;
  final String title;
  final String content;
  UpdateNote({
    required this.id,
    required this.title,
    required this.content,
  });
}

class DeleteNote extends NoteEvent {
  final String id;

  DeleteNote(this.id);
}

class GetNotes extends NoteEvent {}
