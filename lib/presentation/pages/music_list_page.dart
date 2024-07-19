import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../bloc/music_bloc.dart';
import '../bloc/music_event.dart';
import '../bloc/music_state.dart';
import '../widgets/music_list_widget.dart';

class MusicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MusicLoaded) {
            return MusicListWidget(musicList: state.musicList);
          } else if (state is MusicError) {
            return Center(child: Text(state.message));
          } else if (state is MusicPermissionDenied) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Required permissions denied'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MusicBloc>().add(RetryPermissionRequest());
                    },
                    child: Text('Retry'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await openAppSettings();
                    },
                    child: Text('Open App Settings'),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('Press the button to load music'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MusicBloc>().add(LoadMusicList());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
