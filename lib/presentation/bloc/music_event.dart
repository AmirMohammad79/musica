import '../../domain/entities/music.dart';

abstract class MusicEvent {}

class LoadMusicList extends MusicEvent {}

class AddToFavorite extends MusicEvent {
  final Music music;

  AddToFavorite(this.music);
}

class RemoveFromFavorite extends MusicEvent {
  final Music music;

  RemoveFromFavorite(this.music);
}

class LoadFavoriteMusicList extends MusicEvent {}