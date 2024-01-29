import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  const ChatRoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266,
      width: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: neutralThree30,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How can I forget a bad memory?",
                style: getSansFranciscoBold16(color: primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            Text(
              "Forgetting a bad memory entirely may be challenging, as memories are complex and deeply ingrained in our minds.",
              style: getSansFranciscoRegular16(color: neutralThree),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text("30 mins ago",
                style: getSansFranciscoRegular14(color: neutralThree)),
          ],
        ),
      ),
    );
  }
}
