import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/entities/music.dart';
import '../bloc/music_bloc.dart';
import '../bloc/music_event.dart';

class MusicListWidget extends StatelessWidget {
  final List<Music> musicList;

  MusicListWidget({required this.musicList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        final music = musicList[index];
        return ListTile(
          leading: QueryArtworkWidget(
            id: int.parse(music.id),
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
          title: Text(music.title),
          subtitle: Text(music.artist),
          trailing: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              context.read<MusicBloc>().add(AddToFavorite(music));
            },
          ),
        );
      },
    );
  }
}