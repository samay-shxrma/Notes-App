import 'package:flutter/material.dart';
import 'package:frontend/models/notes.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key, this.isUpdate = false, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode notefocus = FocusNode();

  void addNewNote(){
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "samaysharma",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void  updateNote(){
     widget.note!.title = titleController.text;
              widget.note!.content = contentController.text;
              Provider.of<NotesProvider>(context,listen:false).updateNote(widget.note!);
              Navigator.pop(context);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(onPressed: (){
            if(widget.isUpdate){ 
              updateNote();
            }
            else{
              addNewNote();
            }
          }, icon:const Icon(Icons.check))
        ],



        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 153, 255)
      ),
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
          
            TextField(
              controller: titleController,
                autofocus: (widget.isUpdate == true)?false:true,
                onSubmitted: (value) {
                  if(value != ""){
                    notefocus.requestFocus();
                  }
                },
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: notefocus,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                  decoration: const InputDecoration(
                    hintText: "Note",
                    border: InputBorder.none
                  ),
                ),
              )
            ],
          ),
        )
        )
        );
  }
}
