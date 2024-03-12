import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  final String chatRoomName;
  final String date;
  final String latestResponse;
  final int index;

  const ChatRoomCard({
    super.key,
    required this.chatRoomName,
    required this.date,
    required this.latestResponse,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double adjustedHeight = (index % 3 == 0) ? 266 : 286;

    return Container(
      width: 202,
      height: adjustedHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: neutralThree30,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 178,
            child: Text(
              chatRoomName,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: getSansFranciscoBold16(color: primary),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: SizedBox(
              width: 146,
              child: Text(
                latestResponse,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: getSansFranciscoRegular16(color: neutralThree),
              ),
            ),
          ),
          const SizedBox(height: 11),
          Opacity(
            opacity: 0.7,
            child: Text(date,
                style: getSansFranciscoRegular14(color: neutralThree)),
          ),
        ],
      ),
    );
  }
}
