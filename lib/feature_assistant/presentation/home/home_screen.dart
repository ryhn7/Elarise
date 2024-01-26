import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey Madison",
                  style: getGrotesqueSemiBoldStyle24(color: neutralFour)),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "Let's see what can i do for you",
                style: getSansFranciscoRegular14(color: neutralFour),
              )
            ],
          ),
          Image.asset("assets/images/dummy_avatar.png", width: 50, height: 50),
        ]),
        const SizedBox(
          height: 24.0,
        ),
        Text(
          "Start a new chat with",
          style: getGrotesqueSemiBoldStyle40(color: neutralFour),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[
                    Color(0xFFffcf00), // primary color
                    Color(0xFFE8A089), // tumbleweed color
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode
                  .srcIn, // This blend mode applies the gradient only to the text
              child: Text(
                "Elara AI",
                style: getGrotesqueSemiBoldStyle40(
                    color: Colors.white), // Temporarily set to white
              ),
            ),
            SizedBox(
              width: 156,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        bottomLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                        bottomRight: Radius.circular(8),
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                        color: neutralFour,
                      ),
                      Text(
                        "New Topic",
                        style: getSansFranciscoBold16(color: neutralFour),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 32.0,
        ),
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

  Widget history() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24.0,
        ),
        Text("History", style: getSansFranciscoSemiBold24(color: neutralFour)),
        const SizedBox(
          height: 24.0,
        ),
        Container(
          height: 266,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: neutralThree30,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0.0),
            child: Column(
              children: [
                Text("How can I forget a bad memory?",
                    style: getSansFranciscoBold16(color: neutralFour)),
                const SizedBox(height: 12),
                Text(
                  "Forgetting a bad memory entirely may be challenging, as memories are complex and deeply",
                  style: getSansFranciscoRegular16(color: neutralThree),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: neutralOneAlt,
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header(), history()],
          ),
        )));
  }
}
