import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_path_provider/models/note_model.dart';
import 'package:learn_path_provider/pages/note_details.dart';
import 'package:learn_path_provider/widgets/delete_dialog.dart';
import 'package:learn_path_provider/widgets/info_dialog.dart';

import '../service/crud_file.dart';
import '../setup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool cardIsPressed = false;
  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        cardIsPressed = false;
        pressedIndex = null;
        setState(() {});
      },
      canPop: !cardIsPressed,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: cardIsPressed ? Row(
            children: [
              IconButton(
                onPressed: () {
                  cardIsPressed = false;
                  pressedIndex = null;
                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  int index = pressedIndex!;
                  deleteDialog(
                    context: context,
                    noteName: notes[index].name,
                    delete: () async {
                      NoteModel noteModel = notes[index];
                      CRUDFile.deleteFile(noteModel.path);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${noteModel.name} is successfully deleted"),
                          behavior: SnackBarBehavior.floating,
                        )
                      );
                      await setUp();
                      setState(() {});
                      if(!context.mounted) return;
                      Navigator.pop(context);
                    }
                  );
                  cardIsPressed = false;
                  pressedIndex = null;
                  setState(() {});
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  infoDialog(context: context, noteModel: notes[pressedIndex!]);
                  cardIsPressed = false;
                  pressedIndex = null;
                  setState(() {});
                },
                icon: const Icon(Icons.info),
              )
            ],
          ) : const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index){
            final NoteModel noteModel = notes[index];
            return GestureDetector(
              onTap: () {
                if(!cardIsPressed){
                  Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => NoteDetails(noteModel: noteModel))
                  ).then((value) => setState(() {}));
                }
              },
              onLongPress: () {
                cardIsPressed = true;
                pressedIndex = index;
                setState(() {});
              },
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: cardIsPressed && pressedIndex == index ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noteModel.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            noteModel.note,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(noteModel.updateDate, style: const TextStyle(fontWeight: FontWeight.w600))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetails())).then((value) => setState(() {})),
          child: Container(
            width: 125,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30)
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 30),
                SizedBox(width: 5),
                Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(width: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
