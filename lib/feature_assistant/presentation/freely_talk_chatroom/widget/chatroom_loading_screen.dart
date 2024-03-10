import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';

class ChatroomLoadingScreen extends StatelessWidget {
  const ChatroomLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget shimmerEffect(Widget child) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child,
      );
    }

    Widget appBar() {
      return AppBar(
        backgroundColor: darkGray,
        shape: Border(bottom: BorderSide(color: primary, width: 1)),
        elevation: 0,
        leading: shimmerEffect(
          Container(
            width: 10,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        title: Row(
          children: [
            shimmerEffect(
              Image.asset("assets/images/dummy_logo_header.png",
                  width: 40, height: 40),
            ),
            const SizedBox(width: 16),
            shimmerEffect(Container(
              width: 100,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
            )),
          ],
        ),
      );
    }

    Widget responseMessage() {
      return Container(
          margin: const EdgeInsets.only(top: 24, left: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  shimmerEffect(
                    Image.asset("assets/images/dummy_logo.png",
                        width: 24, height: 24),
                  ),
                  const SizedBox(width: 12),
                  shimmerEffect(
                    Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              shimmerEffect(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: blackOlive,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Text("Hello, I'm Elara your virtual assistant.",
                            style:
                                getSansFranciscoRegular16(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    }

    Widget requestMessage() {
      return Container(
        margin: const EdgeInsets.only(top: 48, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                shimmerEffect(
                  Image.asset("assets/images/dummy_logo.png",
                      width: 24, height: 24),
                ),
                const SizedBox(width: 12),
                shimmerEffect(
                  Container(
                    width: 100,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            shimmerEffect(
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Text("Hi Elara, I need help with my order.",
                          style:
                              getSansFranciscoRegular16(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkGray,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        appBar(),
        Expanded(
            child: SingleChildScrollView(
          child: Column(children: [
            responseMessage(),
            requestMessage(),
            responseMessage(),
            requestMessage(),
          ]),
        )),
      ]),
    );
  }
}
