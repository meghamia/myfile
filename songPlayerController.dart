import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controllers/signup_controller.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/MySongModel.dart';

class SongPlayerController extends GetxController {
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


 // List<MySongModel> likedSongs = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storagePermission();
    fetchUserData();
  }

  void toggleFavorite() {
    isLiked = !isLiked;
    update(); // Notify GetX that the state has changed
  }



  //from here i can play the songs
  void playLocalAudio(SongModel song) async {
    songTitle = song.title;
    songArtist = song.artist!;
    isCloudSoundPlaying= false;
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
    songTitle= song.title!;
    songArtist = song.artist!;
    albumUrl= song.albumArt!;
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




  void changeVolume(double volume){
    volumeLevel= volume;
    player.setVolume(volumeLevel);
    print(volumeLevel);
    update();

  }

  void setLoopSong() async{
    if(isLoop){
      await player.setLoopMode(LoopMode.off);
    }else{
      await player.setLoopMode(LoopMode.one);
    }

    isLoop= !isLoop;
update();
}


void playRandomSong() async{
   if(isShuffled){
     await player.setShuffleModeEnabled(false);
   }
   else{
     await player.setShuffleModeEnabled(true);
   }
   isShuffled= !isShuffled;
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
  void changeSongSlider(Duration position){
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
        currentTime= p.toString().split(".")[0];
        sliderValue = p.inSeconds.toDouble();
        update();
      });
    } catch (e) {
      print(e);
    }
    update();
  }
  final audioQuery = OnAudioQuery();

  List<SongModel> localSongList =[];
  bool isDeviceSong = false;
  int currentSongPlayingIndex = 0;


  void getLocalSongs() async {
    localSongList= await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
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
    currentSongPlayingIndex= currentSongPlayingIndex + 1;
    if (currentSongPlayingIndex< songListLen) {
      SongModel nextSong = localSongList[currentSongPlayingIndex];
      playLocalAudio(nextSong);
    }
    update();
  }

  void playPreviousSong(){
    int songListLen = localSongList.length;
    print(currentSongPlayingIndex);
    if(currentSongPlayingIndex!=0){
      currentSongPlayingIndex = --currentSongPlayingIndex;
      if(currentSongPlayingIndex< songListLen){
        SongModel nextSong = localSongList[currentSongPlayingIndex];
        playLocalAudio(nextSong);
      }
      update();
    }

  }
  String userName = '';
  String userEmail = '';
  String userId = '';
  // Future<void> fetchUserData() async {
  //
  //   // Replace 'userId' with the actual user ID from authentication
  //   var userData = await FirebaseFirestore.instance.collection('users').doc('userId').get();
  //   if (userData.exists) {
  //     userName = userData['name'];
  //     userEmail = userData['email'];
  //   }
  //   update();
  // }
  Future<void> fetchUserData() async {
    Map<String, String> userData = Get.find<SignupController>().getUserData();
    userId = userData['userId'] ?? '';
    userName = userData['userName'] ?? '';
    userEmail = userData['userEmail'] ?? '';
    update();
  }

}