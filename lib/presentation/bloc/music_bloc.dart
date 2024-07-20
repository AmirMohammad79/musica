// lib/src/presentation/bloc/music_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musica/domain/uscases/add_favorite_music.dart';
import 'package:musica/domain/uscases/get_favorite.dart';
import '../../domain/uscases/get_music_list.dart';
import '../../domain/uscases/remove_favorite.dart';
import '../../services/permission_service.dart';
import 'music_event.dart';
import 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final GetMusicList getMusicList;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorite getFavoriteMusicList;
  final PermissionService permissionService;

  MusicBloc({
    required this.getMusicList,
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavoriteMusicList,
    required this.permissionService,
  }) : super(MusicInitial()) {
    on<LoadMusicList>(_onLoadMusicList);
    on<AddToFavorite>(_onAddToFavorite);
    on<RemoveFromFavorite>(_onRemoveFromFavorite);
    on<LoadFavoriteMusicList>(_onLoadFavoriteMusicList);
    add(LoadMusicList()); // Trigger loading music list upon bloc creation
  }

  Future<void> _onLoadMusicList(LoadMusicList event, Emitter<MusicState> emit) async {
    emit(MusicLoading());
    final hasPermission = await permissionService.hasPermissions();
    if (!hasPermission) {
      final permissionGranted = await permissionService.requestPermissions();
      if (!permissionGranted) {
        emit(MusicError('Required permissions denied'));
        return;
      }
    }
    try {
      final musicList = await getMusicList();
      emit(MusicLoaded(musicList));
    } catch (e) {
      emit(MusicError(e.toString()));
    }
  }

  Future<void> _onAddToFavorite(AddToFavorite event, Emitter<MusicState> emit) async {
    await addFavorite(event.music);
    emit(FavoriteAdded());
  }

  Future<void> _onRemoveFromFavorite(RemoveFromFavorite event, Emitter<MusicState> emit) async {
    await removeFavorite(event.music);
    emit(FavoriteRemoved());
  }

  Future<void> _onLoadFavoriteMusicList(LoadFavoriteMusicList event, Emitter<MusicState> emit) async {
    emit(MusicLoading());
    try {
      final favoriteMusicList = await getFavoriteMusicList();
      emit(FavoriteMusicLoaded(favoriteMusicList));
    } catch (e) {
      emit(MusicError(e.toString()));
    }
  }
}

