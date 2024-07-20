import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/entities/music.dart';
import '../bloc/music_bloc.dart';
import '../bloc/music_event.dart';
import '../pages/music_playback_page.dart';

class MusicListWidget extends StatelessWidget {
  final List<Music> musicList;

  MusicListWidget({required this.musicList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        final music = musicList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPlaybackPage(music: music, musicList: musicList),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ListTile(
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
            ),
          ),
        );
      },
    );
  }
}