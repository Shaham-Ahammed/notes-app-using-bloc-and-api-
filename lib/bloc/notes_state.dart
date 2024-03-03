part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}


final class NotesFetched extends NotesState {
  final List<NotesModel> notes;
  NotesFetched({required this.notes});
}


final class NotesAdded extends NotesState {}

final class NotesAddingError extends NotesState {
  final String error;

  NotesAddingError(this.error);
}

final class NoteDeleted extends NotesState{}

final class DeletionError extends NotesState {
  final String error;

  DeletionError(this.error);

}

final class NotesUpdationError extends NotesState{
    final String error;

  NotesUpdationError(this.error);
}