import 'package:musica/domain/entities/music.dart';
import 'package:musica/domain/repositories/music_repository.dart';

class RemoveFavorite {
  final MusicRepository repository ;

  RemoveFavorite({required this.repository});

  Future<void> call(Music music) async {
    await repository.removeFavorite(music);
  }
}