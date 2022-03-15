class QuranListModel {
  int? id;
  String? suratName;
  String? suratText;
  String? suratTerjemahan;
  int? countAyat;

  QuranListModel({
    this.id,
    this.suratName,
    this.suratText,
    this.suratTerjemahan,
    this.countAyat
  });

  factory QuranListModel.fromJson(Map<String, dynamic> json) => QuranListModel(
    id: json['id'],
    suratName: json['surat_name'],
    suratText: json['surat_text'],
    suratTerjemahan: json['surat_terjemahan'],
    countAyat: json['count_ayat'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "suratName": suratName,
    "suratText": suratText,
    "suratTerjemahan": suratTerjemahan,
    "countAyat": countAyat
  };
}