import "dart:async";

import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class VideoCard extends StatefulWidget {
  final bool looping;
  final bool autoPlay;
  final bool mute;
  final bool shouldBePaused;

  final Function(bool) shouldBePausedReset;
  final Function(bool) onFavoriteChanged;
  final bool initialFavorite;
  final String videoUrl;
  final String description;
  final bool showFavorite;
  final RightIcon? rightIcon;

  const VideoCard(
      {Key? key,
      required this.autoPlay,
      required this.looping,
      required this.videoUrl,
      this.mute = false,
      required this.showFavorite,
      required this.description,
      required this.initialFavorite,
      required this.onFavoriteChanged,
      required this.shouldBePaused,
      required this.shouldBePausedReset,
      this.rightIcon})
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

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    final videoUrl = widget.videoUrl;
    isMuted = widget.mute;

    if (videoUrl.toLowerCase().contains("youtube")) {
      final VideoID = YoutubePlayer.convertUrlToId(videoUrl);
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
    if (widget.videoUrl.toLowerCase().contains("youtube")) {
      _controllerYoutube?.dispose();
    } else {
      _controllerVideo.dispose();
    }
    super.dispose();
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
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        margin: EdgeInsets.only(top: 15),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // No border radius for the card itself
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                widget.videoUrl.toLowerCase().contains("youtube")
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
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
                if (widget.showFavorite)
                  Container(
                    child: Container(
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
                  ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: widget.rightIcon == null
                      ? EdgeInsets.all(Dimensions.paddingCard)
                      : EdgeInsets.only(left: Dimensions.paddingCard),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                        ),
                      ),
                      if (widget.rightIcon != null)
                        IconButton(
                            onPressed: widget.rightIcon!.onPressRightIcon,
                            icon: Icon(widget.rightIcon!.rightIcon))
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
