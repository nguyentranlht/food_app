import 'package:flutter/material.dart';
import 'package:food_app/models/meal_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoItem extends StatefulWidget {
  final Meal meal;

  const VideoItem({super.key, required this.meal});

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem>
    with SingleTickerProviderStateMixin {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.meal.strYoutube);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller = null; // Giải phóng controller tránh sử dụng sau khi dispose
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 206,
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child:
                    _controller != null
                        ? YoutubePlayer(
                          controller: _controller!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                        )
                        : const Center(child: Text("Không có video")),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "⭐ 5",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 97,
                  child: Text(
                    '1 tiếng 20 phút',
                    style: TextStyle(
                      color: Color(0xFF0043B3),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.18,
                      letterSpacing: 0.06,
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
            child: const Text(
              'Cách chiên trứng một cách cung phu',
              style: TextStyle(
                color: Color(0xFF181B18),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.33,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/Avatar.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Đinh Trọng Phúc',
                  style: TextStyle(
                    color: Color(0xFFCEA700),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.18,
                    letterSpacing: 0.06,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
