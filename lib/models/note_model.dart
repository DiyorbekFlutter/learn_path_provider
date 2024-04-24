class NoteModel {
  String path;
  String name;
  String note;
  String createDate;
  String updateDate;

  NoteModel({
    required this.path,
    required this.name,
    required this.note,
    required this.createDate,
    required this.updateDate
  });
}

List<NoteModel> notes = [];
