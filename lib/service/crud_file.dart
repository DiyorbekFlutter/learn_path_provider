import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CRUDFile {
  static late Directory _directory;
  static late File _file;

  static Future<String> get _getLocation async {
    _directory = await getApplicationDocumentsDirectory();
    return _directory.path;
  }

  static String readFile(String path) => File(path).readAsStringSync();

  static void deleteFile(String path) => File(path).deleteSync();
  
  static Future<void> createFile({required String fileName, required String note}) async {
    DateTime dateTime = DateTime.now();
    String createDate = "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}";
    final String path = await _getLocation;
    _file = File("$path/$fileName-${DateTime.now().toIso8601String()}.txt");
    await _file.writeAsString("$fileName(/split.separated.split/)$note(/split.separated.split/)$createDate(/split.separated.split/)noUpdated");
  }

  static Future<void> updateFile({required String path, required String fileName, required String note, required String createDate}) async {
    _file = File(path);
    DateTime dateTime = DateTime.now();
    String updateDate = "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}";
    await _file.writeAsString("$fileName(/split.separated.split/)$note(/split.separated.split/)$createDate(/split.separated.split/)$updateDate");
  }

  static Future<List<String>> getAllFiles() async {
    List<String> filesPath = [];
    await _getLocation;
    Stream<FileSystemEntity> files = _directory.list();

    await for(FileSystemEntity s in files){
      if(s.path.endsWith('.txt')){
        filesPath.add(s.path);
      }
    }
    return filesPath;
  }
}
