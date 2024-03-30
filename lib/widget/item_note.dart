

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_pad_with_database/add_note/add_note_screen.dart';
import 'package:note_pad_with_database/models/note.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNoteScreen(note: note,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                  child: Column(
                    children: [
                       Text(
                        DateFormat(DateFormat.ABBR_MONTH).format(note.createAt),
                        style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 3),
                       Text(
                         DateFormat(DateFormat.DAY).format(note.createAt),
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 3),
                        Text(
                           note.createAt.year.toString(),
                          style: TextStyle(
                            color: Colors.white70
                          ),
                          ), 
                  ],
                  ),
              ),
              SizedBox(width:15 ,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
        
                          child: Text(
                            note.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            ),
                        ),
                          Text(
        
                             DateFormat(DateFormat.HOUR_MINUTE).format(note.createAt),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                      ],
                    ),
                    
                     Text(
                     note.description,
                     style: TextStyle(
                      fontWeight: FontWeight.w300,
                      height: 1.5
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}