import 'package:katot_elektronik/models/note_model.dart';

abstract class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded({required this.notes});
}

final class NoteError extends NoteState {}
