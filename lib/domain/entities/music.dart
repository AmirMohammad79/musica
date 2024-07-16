class Music {
  final String id;
  final String title;
  final String artist;
  final String url;

  Music(
      {required this.id,
      required this.artist,
      required this.title,
      required this.url});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'artist': artist, 'url': url};
  }

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
        id: json['id'],
        artist: json['artist'],
        title: json['title'],
        url: json['url']);
  }
}
