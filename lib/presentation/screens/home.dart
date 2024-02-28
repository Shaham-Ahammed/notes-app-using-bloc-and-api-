import 'package:bloc_note_app_api/bloc/notes_bloc.dart';
import 'package:bloc_note_app_api/presentation/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<NotesBloc>().add(InitialNotesFetching());
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("TO DO APP"),
        centerTitle: true,
        backgroundColor: Colors.green.shade200,
      ),
      body: BlocConsumer<NotesBloc, NotesState>(listener: (context, state) {
        if (state is NotesAdded) {
          Navigator.of(context).pop();
          titleController.clear();
          descriptionController.clear();
        }
        if (state is NotesAddingError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.error)));
        }
        if (state is NoteDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text("data deleted"))));
        }
        if (state is DeletionError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text(state.error))));
        }
        if (state is NotesUpdationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text(state.error))));
        }
      }, builder: (context, state) {
        if (state is NotesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NotesFetched) {
          if (state.items.isEmpty) {
            return const Expanded(
                child: Center(
              child: Text(
                "add some data",
                style: TextStyle(color: Colors.white),
              ),
            ));
          }
          return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                final id = item['_id'];
                return Padding(
                  padding: index == state.items.length - 1
                      ? const EdgeInsets.only(bottom: 80)
                      : const EdgeInsets.all(0),
                  child: Card(
                    color: Colors.green.shade200,
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: ListTile(
                      title: Text(item['title']),
                      subtitle: Text(item['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showsheet(context, id, index, state);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<NotesBloc>()
                                    .add(DeleteNotePressed(id: id));
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        return const Expanded(
          child: Center(
            child: Text("error in fetching data"),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showsheet(context, null, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 
}
