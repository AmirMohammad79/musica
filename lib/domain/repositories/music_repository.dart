import '../entities/music.dart';

abstract class MusicRepository {
  Future<List<Music>> getMusicList();
  Future<List<Music>> getFavoriteMusicList();
  Future<void> addFavorite(Music music);
  Future<void> removeFavorite(Music music);
}