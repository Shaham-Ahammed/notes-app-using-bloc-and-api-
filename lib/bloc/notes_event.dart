part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class AddNotePressed extends NotesEvent {
  final String title;
  final String description;

  AddNotePressed({required this.title, required this.description});
}

final class EditNotePressed extends NotesEvent {
  final String id;
    final String title;
  final String description;

  EditNotePressed({required this.id, required this.title, required this.description});
}

final class DeleteNotePressed extends NotesEvent {
  final String id;

  DeleteNotePressed({required this.id});
}

final class InitialNotesFetching extends NotesEvent {}
