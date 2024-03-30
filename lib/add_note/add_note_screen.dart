import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_pad_with_database/models/note.dart';
import 'package:note_pad_with_database/repository/note_repository.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key,  this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void initState(){
    if(widget.note!=null){
      _titleController.text=widget.note!.title;
      _descriptionController.text=widget.note!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
         widget.note !=null? IconButton(onPressed: () {
            showDialog(context: context, builder:(context)=>
            AlertDialog(
              content: const Text("Are you sure do you want to delete this note?"),
              actions: [TextButton(onPressed: (){
               Navigator.pop(context);
              }, 
              child:const Text("No") 
              ),

              TextButton(onPressed: (){
               Navigator.pop(context);
               _deleteNote();
              }, 
              child:const Text("Yes") )
              
              ],
            )
            );
          }, icon: const Icon(Icons.delete_outlined)):const SizedBox(),
          IconButton(
            onPressed: widget.note==null? _insertNote:_updatetNote,
            icon: const Icon(Icons.done),
          ),
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(10),
                ),
              ),
              minLines: 3,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  void _insertNote() async {
    //print("TEXT ${_titleController.text}");
    final note = Note(
      title: _titleController.text,
      description: _descriptionController.text,
      createAt: DateTime.now(),
    );
    print(note.title);
    await NotesRepository.insert(note: note);
    setState(() {}); // Trigger UI update
  }
void _updatetNote() async {
    //print("TEXT ${_titleController.text}");
    final note = Note(
      id: widget.note!.id!,
      title: _titleController.text,
      description: _descriptionController.text,
      createAt: widget.note!.createAt,
    );
    //print(note.title);
    await NotesRepository.update(note: note);
    setState(() {}); // Trigger UI update
  }
  void _deleteNote()async
  {
    NotesRepository.delete(note: widget.note!).then((e){
      Navigator.pop(context);
    });
  }

}
