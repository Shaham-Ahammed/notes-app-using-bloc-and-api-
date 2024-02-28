part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesFetched extends NotesState {
  final List<dynamic> items;
  NotesFetched({required this.items});
}

final class NotesAddingError extends NotesState {
  final String error;

  NotesAddingError(this.error);
}

final class NotesLoading extends NotesState {}

final class NotesAdded extends NotesState {}

final class DeletionError extends NotesState {
  final String error;

  DeletionError(this.error);

}

final class NoteDeleted extends NotesState{}

final class NotesUpdationError extends NotesState{
    final String error;

  NotesUpdationError(this.error);
}