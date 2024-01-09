import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class AssistantChatroomScreen extends StatefulWidget {
  const AssistantChatroomScreen({super.key});

  @override
  State<AssistantChatroomScreen> createState() =>
      _AssistantChatroomScreenState();
}

class _AssistantChatroomScreenState extends State<AssistantChatroomScreen> {
  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return AppBar(
        backgroundColor: darkGray,
        shape: Border(bottom: BorderSide(color: primary, width: 1)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image.asset("assets/images/dummy_logo_header.png",
                width: 40, height: 40),
            const SizedBox(width: 16),
            Text(
              "Elara AI",
              style: getSansFranciscoSemiBold20(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
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
                  Image.asset("assets/images/dummy_logo.png",
                      width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(
                    "Elara AI",
                    style: getSansFranciscoSemiBold16(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 12),
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
                Image.asset("assets/images/dummy_avatar.png",
                    width: 24, height: 24),
                const SizedBox(width: 12),
                Text(
                  "You",
                  style: getSansFranciscoSemiBold16(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 12),
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
                        style: getSansFranciscoRegular16(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget chatSpace() {
      return Container(
          margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              isTyping = text.isNotEmpty;
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Type your message here...",
                            hintStyle:
                                getSansFranciscoRegular16(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ]),
              ),
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: isTyping
                        ? InkWell(
                            onTap: () {},
                            child: Image.asset(
                                "assets/icons/icon_send_black.png",
                                width: 32,
                                height: 32),
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic,
                              color: Colors.black,
                              size: 32,
                            )),
                  ))
                ],
              )
            ],
          ));
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
          ]),
        )),
        chatSpace()
      ]),
    );
  }
}
