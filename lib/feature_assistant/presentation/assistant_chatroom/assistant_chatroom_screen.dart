import 'dart:developer';

import 'package:elarise/feature_assistant/domain/entities/talk_freely_response.dart';
import 'package:elarise/feature_assistant/presentation/assistant_chatroom/freely_talk_chat_state_notifier.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../router/router_provider.dart';

class AssistantChatroomScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  const AssistantChatroomScreen(this.chatRoomId, {super.key});

  @override
  ConsumerState<AssistantChatroomScreen> createState() =>
      _AssistantChatroomScreenState();
}

class _AssistantChatroomScreenState
    extends ConsumerState<AssistantChatroomScreen> {
  List<TalkFreelyResponse> messages = [];
  final TextEditingController messageController = TextEditingController();
  bool isTyping = false;

  SpeechToText speechToText = SpeechToText();
  bool isListening = false; // Tracks if the app is currently listening

  @override
  void initState() {
    super.initState();
    checkMicrophoneAvailability();
  }

  void checkMicrophoneAvailability() async {
    bool available = await speechToText.initialize(
      onError: (val) {
        if (kDebugMode) {
          log("Error initializing speech to text: $val");
        }
      },
      onStatus: (status) {
        if (kDebugMode) {
          log("Status: $status");
        }
      },
      debugLogging: true,
    );
    if (available) {
      setState(() {
        if (kDebugMode) {
          log('Microphone available: $available');
        }
      });
    } else {
      if (kDebugMode) {
        log("The user has denied the use of speech recognition.");
      }
    }
  }

  void startListening() {
    speechToText.listen(
      onResult: (result) {
        setState(() {
          messageController.text = result.recognizedWords;
        });

        if (result.finalResult) {
          // If final, send the message
          sendMessage(result.recognizedWords);
        }
      },
      listenFor: const Duration(
          seconds: 60), // Adjust the listening duration as needed
      pauseFor: const Duration(seconds: 3),
    );
  }

  void stopListening() {
    speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    speechToText.stop();
    speechToText.cancel();
    super.dispose();
  }

  void sendMessage(String text) {
    log("chatRoomId: ${widget.chatRoomId}");

    if (text.trim().isEmpty) {
      return; // Prevent sending empty messages
    }

    setState(() {
      messages.add(TalkFreelyResponse(message: text, isUserMessage: true));
      isTyping = false;
    });
    messageController.clear();

    // call method to send message to the server
    ref
        .read(freelyTalkChatStateNotifierProvider.notifier)
        .freelyTalkChat(chatRoomId: widget.chatRoomId, messageText: text);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the FreelyTalkChatState
    final freelyTalkChatState = ref.watch(freelyTalkChatStateNotifierProvider);

    // Handle errors (showing a SnackBar for simplicity)
    if (freelyTalkChatState.error != null && !freelyTalkChatState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(freelyTalkChatState.error!)),
        );
      });
    }

    Widget appBar() {
      return AppBar(
        backgroundColor: darkGray,
        shape: Border(bottom: BorderSide(color: primary, width: 1)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            ref.read(routerProvider).goNamed('home');
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

    Widget buildMessages(TalkFreelyResponse message) {
      bool isUserMessage = message.isUserMessage;
      return Container(
        margin:
            EdgeInsets.only(top: isUserMessage ? 40 : 0, right: 16, left: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: isUserMessage
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!isUserMessage)
                  Image.asset("assets/images/dummy_logo.png",
                      width: 24, height: 24),
                if (isUserMessage)
                  Image.asset("assets/images/dummy_avatar.png",
                      width: 24, height: 24),
                const SizedBox(width: 12),
                Text(
                  isUserMessage ? "You" : "Elara AI",
                  style: getSansFranciscoSemiBold16(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment:
                  isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUserMessage ? Colors.white : blackOlive,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(message.message,
                    style: getSansFranciscoRegular16(
                        color: isUserMessage ? Colors.black : Colors.white)),
              ),
            ),
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
                          controller: messageController,
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
                            onTap: () {
                              if (messageController.text.isNotEmpty) {
                                sendMessage(messageController.text);
                              }
                            },
                            child: Image.asset(
                                "assets/icons/icon_send_black.png",
                                width: 32,
                                height: 32),
                          )
                        : IconButton(
                            onPressed: () {
                              if (isListening) {
                                stopListening();
                              } else {
                                startListening();
                              }
                            },
                            icon: Icon(
                              isListening ? Icons.mic : Icons.mic_off,
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
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 8),
            reverse: true,
            itemCount: freelyTalkChatState.messageResponse.length,
            itemBuilder: ((context, index) {
              // This reverses the message list so that the latest message is at the bottom of the screen.
              int reversedIndex =
                  freelyTalkChatState.messageResponse.length - 1 - index;
              return buildMessages(
                  freelyTalkChatState.messageResponse[reversedIndex]);
            }),
          ),
        ),
        const SizedBox(height: 4),
        chatSpace()
      ]),
    );
  }
}
