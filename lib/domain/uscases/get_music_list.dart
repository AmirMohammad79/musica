import 'package:musica/domain/entities/music.dart';
import 'package:musica/domain/repositories/music_repository.dart';

class GetMusicList {
  final MusicRepository repository;

  GetMusicList({required this.repository});

  Future<List<Music>> call() async{
    return await repository.getMusicList();
  }
}