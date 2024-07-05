import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/notebloc/note_event.dart';
import 'package:katot_elektronik/bloc/notebloc/note_state.dart';
import 'package:katot_elektronik/repository/note_service.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteService noteService;

  NoteBloc({required this.noteService}) : super(NoteInitial()) {
    on<GetNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final noteList = await noteService.getNotes();
        emit(NoteLoaded(notes: noteList));
      } catch (e) {
        emit(NoteError());
      }
    });

    on<AddNote>((event, emit) async {
      try {
        await noteService.addNote(event.title, event.content);
        emit(NoteInitial());
      } catch (e) {
        print(e);
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await noteService.deleteNote(event.id);
        emit(NoteInitial());
      } catch (e) {
        print(e);
      }
    });

    // on<UpdateNote>((event, emit) async {
    //   try {
    //     await noteService.updateNote(event.id, event.title, event.content);
    //     emit(NoteInitial());
    //   } catch (e) {
    //     print(e);
    //   }
    // });
  }
}
