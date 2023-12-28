import 'package:demo/model/MySongModel.dart';
import 'package:demo/screens/likedSongPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../demo/playSongHeaderButton.dart';
import '../demo/songAndVolume.dart';
import '../demo/songControllerButton.dart';
import '../demo/songDetail.dart';
import '../config/colors.dart';
import '../controllers/songPlayerController.dart';
import '../model/LocalMusicModel.dart';

class SongPlayPage extends GetView<HomePageController> {
  //const SongPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    var value = 20.0;

    return SafeArea(
      child: GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(LikedSongPage());
                    },
                    icon: Icon(Icons.favorite))
              ],
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SfRadialGauge(
                    animationDuration: 1,
                    enableLoadingAnimation: true,
                    axes: [
                      RadialAxis(
                        useRangeColorForAxis: true,
                        startAngle: 0,
                        endAngle: 180,
                        canRotateLabels: false,
                        interval: 10,
                        isInversed: true,
                        maximum: 1,
                        minimum: 0,
                        showAxisLine: true,
                        showLabels: false,
                        showTicks: true,
                        ranges: [
                          GaugeRange(
                            startValue: 0,
                            endValue: controller.volumeLevel,
                            color: primaryColor,
                          ),
                        ],
                        pointers: [
                          MarkerPointer(
                            color: primaryColor,
                            borderWidth: 20,
                            value: controller.volumeLevel,
                            onValueChanged: (value) {
                              controller.changeVolume(value);
                            },
                            enableAnimation: true,
                            enableDragging: true,
                            markerType: MarkerType.circle,
                            markerWidth: 20,
                            markerHeight: 20,
                          ),
                        ],
                        annotations: [
                          GaugeAnnotation(
                            horizontalAlignment: GaugeAlignment.center,
                            widget: controller.isCloudSoundPlaying
                                ? Container(
                                    width: 280,
                                    height: 280,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(controller.albumUrl),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(1000),
                                      color: divColor,
                                    ),
                                  )
                                : Container(
                                    width: 280,
                                    height: 280,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/cover.jpg"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(1000),
                                      color: divColor,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/play_outline.svg"),
                      const SizedBox(width: 20),
                      Text(
                        "210 plays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${controller.songTitle}",
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     if (controller
                      //         .localMusicList[
                      //             controller.currentSongPlayingIndex]
                      //         .isLiked!) {
                      //       controller
                      //           .localMusicList[
                      //               controller.currentSongPlayingIndex]
                      //           .isLiked = (false);
                      //     } else {
                      //       controller
                      //           .localMusicList[
                      //               controller.currentSongPlayingIndex]
                      //           .isLiked = (true);
                      //     }
                      //     controller.update();
                      //   },
                      //   icon: Icon(
                      //     controller
                      //                 .localMusicList[
                      //                     controller.currentSongPlayingIndex]
                      //                 .isLiked ==
                      //             true
                      //         ? Icons.favorite
                      //         : Icons.favorite_border,
                      //     color: controller
                      //                 .localMusicList[
                      //                     controller.currentSongPlayingIndex]
                      //                 .isLiked ==
                      //             true
                      //         ? Colors
                      //             .redAccent // You can change this color for testing
                      //         : lableColor,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          int currentSongIndex =
                              controller.currentSongPlayingIndex;
                          LocalMusicModel currentSong =
                              controller.localMusicList[currentSongIndex];

                          // Toggle the liked status
                          controller.toggleLikeStatus(currentSong);
                        },
                        icon: Icon(
                          controller
                                      .localMusicList[
                                          controller.currentSongPlayingIndex]
                                      .isLiked ==
                                  true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller
                                      .localMusicList[
                                          controller.currentSongPlayingIndex]
                                      .isLiked ==
                                  true
                              ? Colors.redAccent
                              : lableColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${controller.songArtist}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Expanded(
                        child: Slider(
                          value: controller.sliderValue
                              .clamp(0.0, controller.sliderValue),
                          onChanged: (value) {
                            controller.sliderValue = value;
                            Duration songPosition =
                                Duration(seconds: value.toInt());
                            controller.changeSongSlider(songPosition);
                          },
                          min: 0,
                          max: controller.sliderMaxValue,
                        ),
                      ),
                      Text(
                        "${controller.currentTime}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.playRandomSong();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/suffle.svg",
                            width: 18,
                            color: controller.isShuffled
                                ? primaryColor
                                : lableColor,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            controller.playPreviousSong();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back.svg",
                            width: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        controller.isPlaying
                            ? InkWell(
                                onTap: () {
                                  controller.pausePlaying();
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/pause.svg",
                                      width: 25,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  controller.resumePlaying();
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/play.svg",
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            controller.playNextSong();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/next.svg",
                            width: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            controller.setLoopSong();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/repeat.svg",
                            width: 18,
                            color:
                                controller.isLoop ? primaryColor : lableColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
