import 'package:bloc_note_app_api/bloc/notes_bloc.dart';
import 'package:bloc_note_app_api/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showsheet(
    BuildContext context, String? id, int? index, NotesFetched? state) {
  if (id != null) {
    titleController.text = state!.items[index!]['title'];
    descriptionController.text = state.items[index]['description'];
  } else {
    if (id == null) {
      titleController.clear();
      descriptionController.clear();
    }
  }
  showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(hintText: "description"),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          id == null
                              ? context.read<NotesBloc>().add(AddNotePressed(
                                  title: titleController.text,
                                  description: descriptionController.text))
                              : context.read<NotesBloc>().add(EditNotePressed(
                                  id: id,
                                  title: titleController.text,
                                  description: descriptionController.text));
                        },
                        child: Text(id == null ? "add" : "update")),
                  )
                ],
              ),
            ),
          ));
}
