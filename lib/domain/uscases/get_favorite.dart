import 'package:musica/domain/repositories/music_repository.dart';

import '../entities/music.dart';

class GetFavorite{
  final MusicRepository repository;

  GetFavorite({required this.repository});

  Future<List<Music>> call() async {
    return await repository.getFavoriteMusicList();
  }
}