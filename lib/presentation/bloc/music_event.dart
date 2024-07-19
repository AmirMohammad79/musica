import '../../domain/entities/music.dart';

abstract class MusicEvent{
  List<Object> get props => [];
}

class LoadMusicList extends MusicEvent {}

class AddToFavorite extends MusicEvent {
  final Music music;

  AddToFavorite(this.music);

  @override
  List<Object> get props => [music];
}

class RemoveFromFavorite extends MusicEvent {
  final Music music;

  RemoveFromFavorite(this.music);

  @override
  List<Object> get props => [music];
}

class LoadFavoriteMusicList extends MusicEvent {}

class RetryPermissionRequest extends MusicEvent {}