import 'package:flutter/material.dart';
import 'package:note_pad_with_database/add_note/add_note_screen.dart';
import 'package:note_pad_with_database/models/note.dart';
import 'package:note_pad_with_database/repository/note_repository.dart';
import 'package:note_pad_with_database/widget/item_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My diary"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              
            });
          }, icon: const Icon(Icons.refresh) )
        ],
      ),
       body: FutureBuilder<List<Note>>(
        future: NotesRepository.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting&&false) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("ERROR IS ${snapshot.error}");
            return Center(child: Text('Error'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("Empty"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemNote(
                  note: snapshot.data![index],
                );
              },
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (_)=> const AddNoteScreen()
          )
          );
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),
      ),
    );
  }
}