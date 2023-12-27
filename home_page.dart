import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/screens/about%20us.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/song_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../components/songTile.dart';
import '../config/colors.dart';
import '../controllers/cloudSongController.dart';
import '../controllers/songPlayerController.dart';

class HomePage extends GetView<HomePageController> {
  var controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    CloudSongController cloudSongController = Get.put(CloudSongController());

    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            key: key,
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.grey),
                      accountEmail: controller.userEmail != null
                          ? Text(controller.userEmail)
                          : Text(''),
                      accountName: controller.userName != null
                          ? Text(controller.userName)
                          : Text(''),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(controller.userName != null &&
                                controller.userName != ""
                            ? (controller.userName
                                    .toUpperCase()
                                    .substring(0, 1) ??
                                "")
                            : ""),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('About Us'),
                    onTap: () {
                      Get.to(AboutUs());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Log Out'),
                    onTap: () {
                      Get.offAllNamed('loginScreen');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sign out'),
                    onTap: () {
                      controller.showConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            key.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        SvgPicture.asset(
                          "assets/icons/big_logo.svg",
                          width: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Music Bag",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Handle the tap on the search icon
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider.builder(
                      itemCount: cloudSongController.trendingSongList.length,
                      itemBuilder: (context, index, realIndex) {
                        print(
                            "Index: $index, RealIndex: $realIndex, List Length: ${cloudSongController.trendingSongList.length}");

                        if (cloudSongController.trendingSongList.isEmpty) {
                          // Handle the case when the list is empty, for example, show a placeholder or return an empty container
                          return Container(); // or show a placeholder widget
                        }
                        //images slider build hone se pehle hi cache mein available  ho jayegi
                        precacheImage(
                            NetworkImage(cloudSongController
                                .trendingSongList[index].albumArt!),
                            context);
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(cloudSongController
                                  .trendingSongList[index].albumArt!),
                              fit: BoxFit.cover,
                            ),
                            color: divColor,
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: divColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/music_node.svg"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Trending",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${cloudSongController.trendingSongList[index].title}",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${cloudSongController.trendingSongList[index].artist}",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: lableColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 320,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 6),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, value) {},
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.isDeviceSong = false;
                            controller.update();
                          },
                          child: Text(
                            "Cloud Song",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: controller.isDeviceSong
                                          ? lableColor
                                          : primaryColor,
                                    ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.isDeviceSong = true;
                            controller.update();
                          },
                          child: Text(
                            "Device Song",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: controller.isDeviceSong
                                          ? primaryColor
                                          : lableColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (controller.isDeviceSong)
                      Column(
                        children: controller.localSongList
                            .map((e) => SongTile(
                                  onPress: () {
                                    controller.playLocalAudio(e);
                                    controller
                                        .findCurrentSongPlayingIndex(e.id);
                                    Get.to(SongPlayPage());
                                  },
                                  songName: e.title,
                                ))
                            .toList(),
                      )
                    else
                      Column(
                        children: cloudSongController.cloudSongList
                            .map((e) => SongTile(
                                  onPress: () {
                                    controller.playCloudAudio(e);
                                    controller
                                        .findCurrentSongPlayingIndex(e.id!);
                                    Get.to(() => SongPlayPage());
                                  },
                                  songName: e.title!,
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
