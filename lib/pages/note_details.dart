import 'package:flutter/material.dart';
import 'package:learn_path_provider/models/note_model.dart';
import 'package:learn_path_provider/service/crud_file.dart';
import 'package:learn_path_provider/setup.dart';

import '../widgets/delete_dialog.dart';
import '../widgets/warning_alert_dialog.dart';
import '../widgets/warning_dialog.dart';

// ignore: must_be_immutable
class NoteDetails extends StatefulWidget {
  NoteModel? noteModel;
  NoteDetails({this.noteModel, super.key});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late final TextEditingController title;
  late final TextEditingController note;
  late final String oldTitle;
  late final String oldNote;

  @override
  void initState() {
    title = TextEditingController(text: widget.noteModel?.name);
    note = TextEditingController(text: widget.noteModel?.note);
    oldTitle = title.text.trim();
    oldNote = note.text.trim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if(oldTitle == title.text.trim() && oldNote == note.text.trim()) {
          return true;
        } else if(oldTitle != title.text.trim() || oldNote != note.text.trim()) {
          return warningDialog(
            context: context,
            saveAndBack: () {
              CRUDFile.createFile(fileName: title.text.trim().isEmpty ? "unknown" : title.text.trim(), note: note.text.trim()).then((value) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Note is successfully saved"),
                    behavior: SnackBarBehavior.floating,
                  )
                );
                await setUp();
                if(!context.mounted) return;
                Navigator.pop(context);
                Navigator.pop(context);
              });
            }
          );
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              const Text("Note", style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if(widget.noteModel == null){
                    if(title.text.trim().isEmpty || note.text.trim().isEmpty){
                      warningAlertDialog(
                        context: context,
                        save: () {
                          CRUDFile.createFile(fileName: title.text.trim().isEmpty ? "unknown" : title.text.trim(), note: note.text.trim()).then((value) async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Note is successfully saved"),
                                behavior: SnackBarBehavior.floating,
                              )
                            );
                            await setUp();
                            if(!context.mounted) return;
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        }
                      );
                    } else {
                      CRUDFile.createFile(fileName: title.text.trim(), note: note.text.trim()).then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Note is successfully saved"),
                            behavior: SnackBarBehavior.floating,
                          )
                        );
                        await setUp();
                        if(!context.mounted) return;
                        Navigator.pop(context);
                      });
                    }
                  } else if(oldTitle != title.text.trim() || oldNote != note.text.trim()){
                    CRUDFile.updateFile(
                      path: widget.noteModel!.path,
                      fileName: title.text.trim().isEmpty ? "unknown" : title.text.trim(),
                      note: note.text.trim(),
                      createDate: widget.noteModel!.createDate
                    ).then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Note is successfully updated"),
                            behavior: SnackBarBehavior.floating,
                          )
                      );
                      await setUp();
                      if(!context.mounted) return;
                      Navigator.pop(context);
                    });
                  } else if(oldTitle == title.text.trim() || oldNote == note.text.trim()){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("O'zgarishlar toplmadi"),
                        behavior: SnackBarBehavior.floating,
                      )
                    );
                  }
                },
                icon: const Icon(Icons.done),
              ),
              PopupMenuButton(
                surfaceTintColor: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: (){
                      title.text = oldTitle;
                      note.text = oldNote;
                      setState((){});
                    },
                    child: const Text("Asliga qaytarish"),
                  ),
                  PopupMenuItem(
                    onTap: (){
                      if(widget.noteModel == null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("O'chirib bo'lmaydi"),
                            behavior: SnackBarBehavior.floating,
                          )
                        );
                        return;
                      }

                      deleteDialog(
                        context: context,
                        noteName: widget.noteModel!.name,
                        delete: () async {
                          CRUDFile.deleteFile(widget.noteModel!.path);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Successfully deleted ${widget.noteModel!.name}"),
                              behavior: SnackBarBehavior.floating,
                            )
                          );
                          await setUp();
                          if(!context.mounted) return;
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      );
                    },
                    child: const Text("Noteni o'chirish"),
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: title,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Note name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(style: BorderStyle.none)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(style: BorderStyle.none)
                  )
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  maxLines: null,
                  controller: note,
                  decoration: const InputDecoration(
                    hintText: "Note content",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    note.dispose();
    super.dispose();
  }
}
