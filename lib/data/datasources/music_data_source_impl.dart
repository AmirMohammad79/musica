import 'dart:convert';
import 'package:on_audio_query/on_audio_query.dart';
import '../../domain/entities/music.dart';
import 'music_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicDataSourceImpl implements MusicDataSource {
  final OnAudioQuery audioQuery;

  MusicDataSourceImpl(this.audioQuery);

  @override
  Future<List<Music>> getMusicList() async {
    final songs = await audioQuery.querySongs();
    return songs
        .map((song) => Music(
              id: song.id.toString(),
              title: song.title,
              artist: song.artist ?? 'Unknown Artist',
              url: song.data,
            ))
        .toList();
  }

  @override
  Future<void> addFavorite(Music music) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorites') ?? [];
    favoriteList.add(jsonEncode(music.toJson()));
    await prefs.setStringList('favorites', favoriteList);
  }

  @override
  Future<void> removeFavorite(Music music) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorites') ?? [];
    favoriteList.removeWhere(
        (item) => Music.fromJson(json.decode(item)).id == music.id);
    await prefs.setStringList('favorites', favoriteList);
  }

  @override
  Future<List<Music>> getFavoriteMusicList() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorites') ?? [];
    return favoriteList
        .map((item) => Music.fromJson(json.decode(item)))
        .toList();
  }
}
