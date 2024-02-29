// ignore_for_file: avoid_print

import 'package:bloc_note_app_api/data/notes_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<InitialNotesFetching>(_initialNotesFetching);
    on<AddNotePressed>(_addNotePressed);
    on<DeleteNotePressed>(_deleteNotePressed);
    on<EditNotePressed>(_editNotePressed);
  }

  //fetching db data
  _initialNotesFetching(
      InitialNotesFetching event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final items =
          await NotesRepository().getData();
      emit(NotesFetched(items: items));
    } catch (e) {
    
      throw Exception(e.toString());
       
    }
  }

  //on add button pressed

  _addNotePressed(AddNotePressed event, Emitter<NotesState> emit) async {
    emit(NotesAdded());
    emit(NotesLoading());
    try {
      final result = await NotesRepository()
          .submitData(event.title, event.description);
      if (result == "success") {
        add(InitialNotesFetching());
      }
    } catch (e) {
      emit(NotesAddingError(e.toString()));
      add(InitialNotesFetching());
    }
  }

  //delete button press

  _deleteNotePressed(DeleteNotePressed event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final result = await NotesRepository()
          .deleteData(event.id);
      if (result == "success") {
        emit(NoteDeleted());
        add(InitialNotesFetching());
      }
    } catch (e) {
      emit(DeletionError(e.toString()));
      add(InitialNotesFetching());
    }
  }
  
  //edit button pressed

  _editNotePressed(EditNotePressed event, Emitter<NotesState> emit) async {
    emit(NotesAdded());
    emit(NotesLoading());
    try {
      final result = await NotesRepository()
          .updateData(event.id, event.title, event.description);
      if (result == "success") {
        add(InitialNotesFetching());
      } else {
        emit(NotesUpdationError("error in updating"));
        add(InitialNotesFetching());
      }
    } catch (e) {
      emit(NotesUpdationError(e.toString()));  
    }
  }


  @override
  void onTransition(Transition<NotesEvent, NotesState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
