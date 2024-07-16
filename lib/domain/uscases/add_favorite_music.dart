import 'package:musica/domain/repositories/music_repository.dart';

import '../entities/music.dart';

class AddFavoriteMusic{

  final MusicRepository repository;

  AddFavoriteMusic({required this.repository});

  Future<void> call(Music music) async {

    await repository.addFavorite(music);
  }
}