import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/entities/music.dart';

class MusicPlaybackPage extends StatefulWidget {
  final Music music;
  final List<Music> musicList;

  MusicPlaybackPage({required this.music, required this.musicList});

  @override
  _MusicPlaybackPageState createState() => _MusicPlaybackPageState();
}

class _MusicPlaybackPageState extends State<MusicPlaybackPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic(widget.music);
  }

  Future<void> _playMusic(Music music) async {
    await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(music.url)));
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.music.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QueryArtworkWidget(
            id: int.parse(widget.music.id), // Convert music.id to int
            type: ArtworkType.AUDIO,
            artworkHeight: 250,
            artworkWidth: 250,
            nullArtworkWidget: Icon(Icons.music_note, size: 250),
          ),
          SizedBox(height: 20),
          Text(
            widget.music.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.music.artist,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () async {
                  // Implement previous track functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _audioPlayer.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  _audioPlayer.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () async {
                  // Implement next track functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}