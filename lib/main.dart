import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musica/presentation/bloc/music_bloc.dart';
import 'package:musica/presentation/pages/music_list_page.dart';
import 'package:musica/services/permission_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'data/datasources/music_data_source_impl.dart';
import 'data/repositories/music_repository_impl.dart';
import 'domain/uscases/add_favorite_music.dart';
import 'domain/uscases/get_favorite.dart';
import 'domain/uscases/get_music_list.dart';
import 'domain/uscases/remove_favorite.dart';

void main() {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final MusicDataSourceImpl musicDataSource = MusicDataSourceImpl(audioQuery);
  final MusicRepositoryImpl musicRepository = MusicRepositoryImpl(dataSource: musicDataSource);

  runApp(MyApp(
    getMusicList: GetMusicList( repository: musicRepository),
    addFavorite:  AddFavorite( repository: musicRepository),
    removeFavorite: RemoveFavorite( repository: musicRepository),
    getFavoriteMusicList: GetFavorite( repository: musicRepository),
  ));
}

class MyApp extends StatelessWidget {
  final GetMusicList getMusicList;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorite getFavoriteMusicList;

  MyApp({
    required this.getMusicList,
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavoriteMusicList,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MusicBloc(
          getMusicList: getMusicList,
          addFavorite: addFavorite,
          removeFavorite: removeFavorite,
          getFavoriteMusicList: getFavoriteMusicList,
          permissionService: PermissionService(),
        ),
        child: MusicListPage(),
      ),
    );
  }
}
