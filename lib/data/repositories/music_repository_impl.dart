import '../../domain/entities/music.dart';
import '../../domain/repositories/music_repository.dart';
import '../datasources/music_data_source.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicDataSource dataSource;

  MusicRepositoryImpl({required this.dataSource});

  @override
  Future<List<Music>> getMusicList() async {
    return await dataSource.getMusicList();
  }

  @override
  Future<List<Music>> getFavoriteMusicList() async {
    return await dataSource.getFavoriteMusicList();
  }

  @override
  Future<void> addFavorite(Music music) async {
    await dataSource.addFavorite(music);
  }

  @override
  Future<void> removeFavorite(Music music) async {
    await dataSource.removeFavorite(music);
  }
}
