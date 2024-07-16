import '../../domain/entities/music.dart';

abstract class MusicState {}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<Music> musicList;

  MusicLoaded(this.musicList);
}

class MusicError extends MusicState {
  final String message;

  MusicError(this.message);
}

class FavoriteAdded extends MusicState {}

class FavoriteRemoved extends MusicState {}

class FavoriteMusicLoaded extends MusicState {
  final List<Music> favoriteMusicList;

  FavoriteMusicLoaded(this.favoriteMusicList);
}