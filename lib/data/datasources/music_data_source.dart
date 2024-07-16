import '../../domain/entities/music.dart';

abstract class MusicDataSource {
  Future<List<Music>> getMusicList();
  Future<List<Music>> getFavoriteMusicList();
  Future<void> addFavorite(Music music);
  Future<void> removeFavorite(Music music);
}