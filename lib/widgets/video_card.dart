import "dart:async";

import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class VideoCard extends StatefulWidget {
  final bool looping;
  final bool autoPlay;
  final bool mute;
  final bool shouldBePaused;
  final bool resetCheckCard;

  final Function(bool)? updateResetCheckCard;
  final Function(bool) shouldBePausedReset;
  final Function(bool) onFavoriteChanged;
  final Function(bool) handleCheckedVideoCard;
  final bool initialFavorite;
  final String videoUrl;
  final String description;
  final bool showChecked;
  final bool showFavorite;
  final List<RightIcon>? rightIcons;

  const VideoCard(
      {Key? key,
      required this.autoPlay,
      this.resetCheckCard = false,
      this.updateResetCheckCard,
      required this.looping,
      required this.videoUrl,
      this.mute = false,
      required this.showFavorite,
      required this.description,
      required this.initialFavorite,
      required this.onFavoriteChanged,
      required this.shouldBePaused,
      required this.shouldBePausedReset,
      required this.showChecked,
      required this.handleCheckedVideoCard,
      this.rightIcons})
      : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final favoriteColor = AppColors.secondaryMainColor;
  bool isMarkAsFavorite = false;
  late VideoPlayerController _controllerVideo;
  late YoutubePlayerController? _controllerYoutube;
  bool isMuted = true;
  bool isCheckedCard = false;

  late Future<void> _initializeVideoPlayerFuture;

  bool isYoutubeVideo() {
    return widget.videoUrl.toLowerCase().contains("youtube") ||
        widget.videoUrl.toLowerCase().contains("youtu.be");
  }

  String? getIDYoutube(String url) {
    RegExp regExp = RegExp(
      r"^(?:https:\/\/)?(?:www\.)?youtu\.?be(?:\.com)?\/(?:watch\?v=)?([\w-]+)",
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    final videoUrl = widget.videoUrl;
    isMuted = widget.mute;
    isMarkAsFavorite = widget.initialFavorite;

    if (isYoutubeVideo()) {
      String? VideoID = YoutubePlayer.convertUrlToId(videoUrl);
      if (VideoID == null) {
        VideoID = getIDYoutube(videoUrl);
      }

      _controllerYoutube = YoutubePlayerController(
        initialVideoId: VideoID!,
        flags: YoutubePlayerFlags(
          mute: isMuted,
          autoPlay: false,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
    } else {
      _controllerVideo = VideoPlayerController.networkUrl(
        Uri.parse(
          videoUrl,
        ),
      );

      _initializeVideoPlayerFuture =
          _controllerVideo.initialize().then((value) {
        setState(() {
          if (widget.autoPlay) {
            _controllerVideo.play();
          }
          _controllerVideo.setLooping(widget.looping);
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (isYoutubeVideo()) {
      _controllerYoutube?.dispose();
    } else {
      _controllerVideo.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoCard oldWidget) {
    if (isCheckedCard == true && widget.resetCheckCard == true) {
      setState(() => isCheckedCard = false);
      widget.updateResetCheckCard!(false);
    }
    super.didUpdateWidget(oldWidget);
  }

  void listener() {
    if (widget.shouldBePaused) {
      _controllerYoutube?.pause();
      widget.shouldBePausedReset(false);
    }
  }
// void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//         _videoMetaData = _controller.metadata;
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // No border radius for the card itself
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                isYoutubeVideo()
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: YoutubePlayer(
                          controller: _controllerYoutube!,
                          showVideoProgressIndicator: true,
                          bottomActions: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isMuted = !isMuted;
                                  if (isMuted) {
                                    _controllerYoutube?.mute();
                                  } else {
                                    _controllerYoutube?.unMute();
                                  }
                                });
                              },
                              icon: Icon(isMuted
                                  ? Icons.volume_off
                                  : Icons.volume_up_sharp),
                              color: Colors.white,
                            ),
                            const SizedBox(width: 14.0),
                            CurrentPosition(),
                            const SizedBox(width: 8.0),
                            ProgressBar(isExpanded: true),
                            RemainingDuration(),
                            const PlaybackSpeedButton(),
                          ],
                        ),
                      )
                    : FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return VideoPlayer(_controllerVideo);
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.showChecked)
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Checkbox(
                              value: isCheckedCard,
                              onChanged: (p0) {
                                setState(() => isCheckedCard = p0!);
                                widget.handleCheckedVideoCard(p0!);
                              })),
                    if (widget.showFavorite)
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          icon: Icon(
                            isMarkAsFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: favoriteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isMarkAsFavorite = !isMarkAsFavorite;
                            });
                            widget.onFavoriteChanged(isMarkAsFavorite);
                          },
                        ),
                      ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingCard, right: responsive.wp(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: responsive.hp(1.20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.rightIcons != null)
                            for (final rightIcon in widget.rightIcons!)
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  IconButton(
                                      iconSize: responsive.hp(2.10),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: rightIcon.onPressRightIcon,
                                      icon: Icon(rightIcon.rightIcon))
                                ],
                              )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class RightIcon {
  final VoidCallback onPressRightIcon;
  final IconData rightIcon;

  RightIcon({required this.onPressRightIcon, required this.rightIcon});
}
