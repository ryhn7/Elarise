import 'package:elarise/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatRoomLoadingCard extends StatelessWidget {
  final int index;

  const ChatRoomLoadingCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double adjustedHeight = (index % 3 == 0) ? 266 : 286;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 202,
        height: adjustedHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: neutralThree30,
            width: 1,
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
