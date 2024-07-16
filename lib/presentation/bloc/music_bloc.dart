import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/uscases/add_favorite_music.dart';
import '../../domain/uscases/get_favorite.dart';
import '../../domain/uscases/get_music_list.dart';
import '../../domain/uscases/remove_favorite.dart';
import '../../services/permission_service.dart';
import 'music_event.dart';
import 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final GetMusicList getMusicList;
  final AddFavoriteMusic addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorite getFavoriteMusicList;
  final PermissionService permissionService;

  MusicBloc({
    required this.getMusicList,
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavoriteMusicList,
    required this.permissionService,
  }) : super(MusicInitial());

  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    if (event is LoadMusicList) {
      yield MusicLoading();
      final hasPermission = await permissionService.requestStoragePermission();
      if (hasPermission) {
        try {
          final musicList = await getMusicList();
          yield MusicLoaded(musicList);
        } catch (e) {
          yield MusicError(e.toString());
        }
      } else {
        yield MusicError('Storage permission denied');
      }
    } else if (event is AddToFavorite) {
      await addFavorite(event.music);
      yield FavoriteAdded();
    } else if (event is RemoveFromFavorite) {
      await removeFavorite(event.music);
      yield FavoriteRemoved();
    } else if (event is LoadFavoriteMusicList) {
      yield MusicLoading();
      try {
        final favoriteMusicList = await getFavoriteMusicList();
        yield FavoriteMusicLoaded(favoriteMusicList);
      } catch (e) {
        yield MusicError(e.toString());
      }
    }
  }
}