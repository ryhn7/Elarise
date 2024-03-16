import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String action;
  final String image;
  final Color color;
  final Color fontColor;
  final VoidCallback onTap;

  const FeatureCard(
      {super.key,
      required this.title,
      required this.description,
      required this.action,
      required this.image,
      required this.color,
      required this.fontColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 172,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
          child: Stack(children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  image, // Path to your sun image asset
                  width: 120, // Adjust the size accordingly
                  height: 120, // Adjust the size accordingly
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: getSansFranciscoExtraBold20(color: fontColor),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: getSansFranciscoRegular16(color: fontColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            action,
                            style: getSansFranciscoMedium16(color: neutralFour),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
