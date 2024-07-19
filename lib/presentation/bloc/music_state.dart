import '../../domain/entities/music.dart';

abstract class MusicState {
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<Music> musicList;

  MusicLoaded(this.musicList);

  @override
  List<Object> get props => [musicList];
}

class MusicError extends MusicState {
  final String message;

  MusicError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteAdded extends MusicState {}

class FavoriteRemoved extends MusicState {}

class FavoriteMusicLoaded extends MusicState {
  final List<Music> favoriteMusicList;

  FavoriteMusicLoaded(this.favoriteMusicList);

  @override
  List<Object> get props => [favoriteMusicList];
}

class MusicPermissionDenied extends MusicState {}