//
// class MySongModel {
//   int? id;
//   String? title;
//   String? artist;
//   String? album;
//   String? albumArt;
//   String? data;
//
//
//   MySongModel({this.id, this.title, this.artist, this.album, this.albumArt, this.data});
//
//   MySongModel.fromJson(Map<String, dynamic> json) {
//     if(json["id"] is int) {
//       id = json["id"];
//     }
//     if(json["title"] is String) {
//       title = json["title"];
//     }
//     if(json["artist"] is String) {
//       artist = json["artist"];
//     }
//     if(json["album"] is String) {
//       album = json["album"];
//     }
//     if(json["albumArt"] is String) {
//       albumArt = json["albumArt"];
//     }
//     if(json["data"] is String) {
//       data = json["data"];
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["title"] = title;
//     _data["artist"] = artist;
//     _data["album"] = album;
//     _data["albumArt"] = albumArt;
//     _data["data"] = data;
//     return _data;
//   }
// }
//
//



class MySongModel {



  int? id;
  String? title;
  String? artist;
  String? album;
  String? albumArt;
  String? data;
  late bool isLiked;

  MySongModel({
    this.id,
    this.title,
    this.artist,
    this.album,
    this.albumArt,
    this.data,
    bool? isLiked,
  }) : isLiked = isLiked ?? false;

  MySongModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] as int?;
    title = json["title"] as String?;
    artist = json["artist"] as String?;
    album = json["album"] as String?;
    albumArt = json["albumArt"] as String?;
    data = json["data"] as String?;
    isLiked = json["isLiked"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["artist"] = artist;
    _data["album"] = album;
    _data["albumArt"] = albumArt;
    _data["data"] = data;
    _data["isLiked"] = isLiked;
    return _data;
  }
}
