import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controllers/signup_controller.dart';
import 'package:demo/model/LocalMusicModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/MySongModel.dart';
import '../screens/likedSongPage.dart';
import 'cloudSongController.dart';

class HomePageController extends GetxController {
  MySongModel? currentSong;

  final player = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "0";
  String totalTime = "0";
  double sliderValue = 0.0;
  double sliderMaxValue = 0.0;
  String songTitle = "";
  String songArtist = "";
  bool isLoop = false;
  bool isShuffled = false;
  double volumeLevel = 0.2;
  bool isLiked = false;
  bool isCloudSoundPlaying = false;
  String albumUrl = "";

  // void addToLikedSongs(MySongModel song) {
  //   if (!likedSongs.contains(song)) {
  //     likedSongs.add(song);
  //   }
  // }
  //
  // void removeFromLikedSongs(MySongModel song) {
  //   likedSongs.remove(song);
  // }

  // void toggleFavorite() {
  //   print("currentSong: $currentSong");
  //   print("Toggle Favorite Called");
  //
  //   if (currentSong != null) {
  //     // Toggle liked state for the current song
  //     currentSong!.isLiked = !currentSong!.isLiked;
  //
  //     // Add or remove the current song from the likedSongs list based on the liked state
  //     if (currentSong!.isLiked) {
  //       likedSongs.add(currentSong!);
  //     } else {
  //       likedSongs.removeWhere((song) => song.id == currentSong!.id);
  //     }
  //
  //     print("isLiked: ${currentSong!.isLiked}");
  //     print("likedSongs: $likedSongs");
  //
  //     update(); // Notify GetX that the state has changed
  //   }
  // }
  List<LocalMusicModel> likedSong = []; // List to store liked songs

  void toggleLikeStatus(LocalMusicModel song) {
    song.isLiked = !song.isLiked;

    if (song.isLiked==true) {
      likedSong.add(song);
    } else {
      likedSong.remove(song);
    }
    print("Liked Songs: ${likedSong}");
    print("Liked Songs: ${song.isLiked.toString()}");
    update(); // Trigger UI update
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentSong = MySongModel();
    storagePermission();
    fetchUserData();
  }

  //from here i can play the songs
  void playLocalAudio(SongModel song) async {
    songTitle = song.title;
    songArtist = song.artist!;
    isCloudSoundPlaying = false;

    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(song.data),
      ),
    );
    player.play();
    updatePosition(); //calling this function here k jaise hi song play ho hamari possition update hona start ho jaye
    isPlaying = true;

    update();
  }

  void playCloudAudio(MySongModel song) async {
    songTitle = song.title!;
    songArtist = song.artist!;
    albumUrl = song.albumArt!;
    isCloudSoundPlaying = true;
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(song.data!),
      ),
    );
    player.play();
    updatePosition(); //calling this function here k jaise hi song play ho hamari possition update hona start ho jaye
    isPlaying = true;
    update();
  }

  void changeVolume(double volume) {
    volumeLevel = volume;
    player.setVolume(volumeLevel);
    print(volumeLevel);
    update();
  }

  void setLoopSong() async {
    if (isLoop) {
      await player.setLoopMode(LoopMode.off);
    } else {
      await player.setLoopMode(LoopMode.one);
    }

    isLoop = !isLoop;
    update();
  }

  void playRandomSong() async {
    if (isShuffled) {
      await player.setShuffleModeEnabled(false);
    } else {
      await player.setShuffleModeEnabled(true);
    }
    isShuffled = !isShuffled;
    update();
  }

//from where the song has stopped it starts from there means resume there...
  void resumePlaying() async {
    isPlaying = true;
    await player.play();
    update();
  }

  //from here i can pause the songs
  void pausePlaying() async {
    isPlaying = false;
    await player.pause();
    update();
  }

//somg willl move to that position from where the song will resume or start..
  void changeSongSlider(Duration position) {
    player.seek(position);
    update();
  }

  void updatePosition() async {
    try {
      player.durationStream.listen((d) {
        totalTime = d.toString().split(".")[0];
        sliderMaxValue = d!.inSeconds.toDouble();
        update();
      });
      player.positionStream.listen((p) {
        currentTime = p.toString().split(".")[0];
        sliderValue = p.inSeconds.toDouble();
        update();
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  final audioQuery = OnAudioQuery();

  List<SongModel> localSongList = [];
  List<LocalMusicModel> localMusicList = [];

  bool isDeviceSong = false;
  int currentSongPlayingIndex = 0;

  void getLocalSongs() async {
    localSongList = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    localSongList.forEach((element) {
      localMusicList.add(LocalMusicModel.fromJson(element.getMap));
    });
    print(localSongList);
    update();
  }

  void storagePermission() async {
    try {
      var perm = await Permission.storage.request();

      if (perm.isGranted) {
        print("permission Granted");
        getLocalSongs();
      } else {
        print("Permission Denied");
        await Permission.storage.request();
      }
    } catch (ex) {
      print(ex);
    }
    update();
  }

  void findCurrentSongPlayingIndex(int songId) {
    var index = 0;
    localSongList.forEach((e) {
      if (e.id == songId) {
        currentSongPlayingIndex = index;
      }
      index++;
    });
    print(songId);
    print(currentSongPlayingIndex);
    update();
  }

  void playNextSong() {
    int songListLen = localSongList.length;
    currentSongPlayingIndex = currentSongPlayingIndex + 1;
    if (currentSongPlayingIndex < songListLen) {
      SongModel nextSong = localSongList[currentSongPlayingIndex];
      playLocalAudio(nextSong);
    }
    update();
  }

  void playPreviousSong() {
    int songListLen = localSongList.length;
    print(currentSongPlayingIndex);
    if (currentSongPlayingIndex != 0) {
      currentSongPlayingIndex = --currentSongPlayingIndex;
      if (currentSongPlayingIndex < songListLen) {
        SongModel nextSong = localSongList[currentSongPlayingIndex];
        playLocalAudio(nextSong);
      }
      update();
    }
  }

  String userName = '';
  String userEmail = '';
  String userId = '';

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name') ?? '';
    userEmail = prefs.getString('email') ?? '';
    update();
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context, false); // Close the dialog with result 'false'
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('signupScreen');
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
