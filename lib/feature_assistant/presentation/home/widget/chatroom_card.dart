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
    Color backgroundColor = index % 2 == 0 ? earieBlack : primary;
    Color textColor = index % 2 == 0 ? Colors.white : earieBlack;
    Color iconColor = index % 2 == 0 ? primary : Colors.white;

    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Container(
          width: 380,
          padding: const EdgeInsets.only(
            left: 24,
            right: 8,
            top: 4,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 264,
                    child: Text(
                      chatRoomName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSansFranciscoBold16(color: textColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward,
                      color: iconColor,
                      size: 24,
                    ),
                  )
                ],
              ),
              // const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: Opacity(
                  opacity: 0.7,
                  child: Text(
                    latestResponse,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getSansFranciscoRegular16(color: textColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Opacity(
                opacity: 0.7,
                child: Text(date,
                    style: getSansFranciscoRegular14(color: textColor)),
              ),
            ],
          )),
    );
  }
}
