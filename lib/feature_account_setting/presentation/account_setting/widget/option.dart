import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String title;
  final String? information;
  final String? subtitle;
  const Option(
      {super.key, this.information, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: getSansFranciscoMedium18(color: neutralFour)),
                  if (subtitle?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 8),
                    Text(subtitle ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: getSansFranciscoRegular14(color: neutralThree)),
                  ]
                ],
              ),
            ),
            Row(
              children: [
                Text(information ?? "",
                    style: getSansFranciscoRegular16(color: neutralThree)),
                const SizedBox(width: 16),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 20, color: neutralThree),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: Divider(
                color: neutralThree30,
                height: 1,
                thickness: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
