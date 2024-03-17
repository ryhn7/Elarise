import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatRoomLoadingCard extends StatelessWidget {
  const ChatRoomLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 380,
          height: 144,
          padding: const EdgeInsets.only(
            left: 24,
            right: 8,
            top: 4,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: Colors.grey[100],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
