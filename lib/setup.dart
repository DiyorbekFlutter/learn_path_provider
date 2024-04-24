import 'package:learn_path_provider/models/note_model.dart';
import 'package:learn_path_provider/service/crud_file.dart';

Future<void> setUp() async {
  notes = [];
  List<String> paths = await CRUDFile.getAllFiles();
  paths.map((path) => notes.add(fileToModel(path))).toList();
}

NoteModel fileToModel(String path){
  List<String> list = CRUDFile.readFile(path).split("(/split.separated.split/)");
  return NoteModel(
    path: path,
    name: list[0],
    note: list[1],
    createDate: list[2],
    updateDate: list[3]
  );
}
