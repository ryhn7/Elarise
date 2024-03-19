import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/feature_assistant/presentation/grammar_talk_chatroom/grammar_talk_chat_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shimmer/shimmer.dart';

import '../../../router/router_provider.dart';
import '../../../theme/colors.dart';
import '../../../theme/style.dart';
import '../../domain/entities/elara_response.dart';

class GrammarTalkChatroomScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  const GrammarTalkChatroomScreen(this.chatRoomId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrammarTalkChatroomScreenState();
}

class _GrammarTalkChatroomScreenState
    extends ConsumerState<GrammarTalkChatroomScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(grammarTalkChatStateNotifierProvider.notifier).chatRoomId =
        widget.chatRoomId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(grammarTalkChatStateNotifierProvider.notifier).clearChat();
    }); // Clear the chat when entering a new room

    log(widget.chatRoomId);
  }

  void sendMessage(String text) {
    final messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      ref.read(grammarTalkChatStateNotifierProvider.notifier).sendMessage(text);
      messageController.clear();

      // Also reset the typing state
      ref
          .read(grammarTalkChatStateNotifierProvider.notifier)
          .updateTypingState(false);
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the grammarTalkChatState
    final grammarTalkChatState =
        ref.watch(grammarTalkChatStateNotifierProvider);

    // Handle errors (showing a SnackBar for simplicity)
    if (grammarTalkChatState.error != null && !grammarTalkChatState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(grammarTalkChatState.error!)),
        );
      });
    }

    // if (!grammarTalkChatState.isTyping &&
    //     messageController.text != grammarTalkChatState.currentSpokenWord) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     messageController.text = grammarTalkChatState.currentSpokenWord;
    //     messageController.selection = TextSelection.fromPosition(
    //         TextPosition(offset: messageController.text.length));
    //   });
    // }

    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        shape: Border(bottom: BorderSide(color: primary, width: 1)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: earieBlack),
          onPressed: () {
            ref.read(routerProvider).goNamed('home');
          },
        ),
        title: Row(
          children: [
            Image.asset("assets/images/elarise_logo.png",
                width: 40, height: 40),
            const SizedBox(width: 16),
            Text(
              "Elara AI",
              style: getSansFranciscoSemiBold20(color: earieBlack),
            )
          ],
        ),
      );
    }

    Widget buildMessages(ElaraResponse message) {
      final userState = ref.watch(grammarTalkChatStateNotifierProvider);
      final fullName = userState.userPreferences?.name ?? "User";
      final userName = fullName.split(" ")[0];

      final userPhoto = userState.userPreferences?.photoProfile ??
          "https://firebasestorage.googleapis.com/v0/b/elarise-1d057.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=edfb4a25-2f56-479c-9ed3-f58e90ca8ce5";

      bool isUserMessage = message.isUserMessage;

      if (message.isPlaceholder) {
        return Container(
          margin: const EdgeInsets.only(top: 0, right: 16, left: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/elarise_logo_small.png",
                      width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(
                    "Elara AI",
                    style: getSansFranciscoSemiBold16(color: earieBlack),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.2,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: JumpingDots(
                      color: earieBlack,
                      radius: 8,
                      numberOfDots: 3,
                    )),
              ),
            ],
          ),
        );
      } else {
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
                    Image.asset("assets/images/elarise_logo_small.png",
                        width: 24, height: 24),
                  if (isUserMessage)
                    CachedNetworkImage(
                      imageUrl: userPhoto,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  const SizedBox(width: 12),
                  Text(
                    isUserMessage ? userName : "Elara AI",
                    style: getSansFranciscoSemiBold16(color: earieBlack),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: isUserMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUserMessage ? blackOlive : primary,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Text(message.message,
                      style: getSansFranciscoRegular16(
                          color: isUserMessage ? Colors.white : earieBlack)),
                ),
              ),
            ],
          ),
        );
      }
    }

    Widget chatSpace() {
      // Listen to the grammarTalkChatState
      final grammarTalkChatState =
          ref.watch(grammarTalkChatStateNotifierProvider);

      return Container(
          margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 4, bottom: 8),
                decoration: const BoxDecoration(
                  color: lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          onChanged: (text) {
                            ref
                                .read(grammarTalkChatStateNotifierProvider
                                    .notifier)
                                .updateTypingState(text.isNotEmpty);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Type your message here...",
                            hintStyle: getSansFranciscoRegular16(color: gray),
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
                    child: grammarTalkChatState.isTyping
                        ? InkWell(
                            onTap: () {
                              if (messageController.text.trim().isNotEmpty) {
                                sendMessage(messageController.text.trim());
                              }
                            },
                            child: Image.asset(
                                "assets/icons/icon_send_black.png",
                                width: 32,
                                height: 32),
                          )
                        : IconButton(
                            onPressed: () {
                              if (grammarTalkChatState.isListening) {
                                ref
                                    .read(grammarTalkChatStateNotifierProvider
                                        .notifier)
                                    .stopListening();
                              } else {
                                ref
                                    .read(grammarTalkChatStateNotifierProvider
                                        .notifier)
                                    .startListening();
                              }
                            },
                            icon: Icon(
                              grammarTalkChatState.isSpeaking
                                  ? Icons.mic
                                  : Icons.mic_off,
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
      backgroundColor: neutralOneAlt,
      appBar: appBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 8),
            reverse: true,
            itemCount: grammarTalkChatState.messageResponse.length,
            itemBuilder: ((context, index) {
              // This reverses the message list so that the latest message is at the bottom of the screen.
              int reversedIndex =
                  grammarTalkChatState.messageResponse.length - 1 - index;
              return buildMessages(
                  grammarTalkChatState.messageResponse[reversedIndex]);
            }),
          ),
        ),
        const SizedBox(height: 4),
        chatSpace()
      ]),
    );
  }
}
