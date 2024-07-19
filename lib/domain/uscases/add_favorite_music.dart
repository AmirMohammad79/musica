import 'package:flutter/cupertino.dart';
import 'package:musica/domain/repositories/music_repository.dart';

import '../entities/music.dart';

class AddFavorite {
  final MusicRepository repository;

  AddFavorite({required this.repository});

  Future<void> call(Music music) async {
    return await repository.addFavorite(music);
  }
}