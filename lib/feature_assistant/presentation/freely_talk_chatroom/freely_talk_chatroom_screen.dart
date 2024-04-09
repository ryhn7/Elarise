import 'dart:developer';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';
import 'package:elarise/feature_assistant/presentation/freely_talk_chatroom/freely_talk_chat_state_notifier.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/global/global_state_notifier.dart';
import '../../../router/router_provider.dart';
import '../home/home_state_notifier.dart';

class FreelyTalkChatroomScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  final bool isNewChatRoom;

  const FreelyTalkChatroomScreen(this.chatRoomId,
      {super.key, this.isNewChatRoom = false});

  @override
  ConsumerState<FreelyTalkChatroomScreen> createState() =>
      _FreelyTalkChatroomScreenState();
}

class _FreelyTalkChatroomScreenState
    extends ConsumerState<FreelyTalkChatroomScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(freelyTalkChatStateNotifierProvider.notifier);
    notifier.chatRoomId = widget.chatRoomId;

    if (widget.isNewChatRoom) {
      // If it's a new chat room, clear any previous chat state
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.clearChat();
      });
    } else {
      // Otherwise, fetch the talk history for the given chatRoomId
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.fetchTalkHistory();
      });
    }

    log(widget.chatRoomId);
  }

  void scrollToLastWord() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the FreelyTalkChatState
    final freelyTalkChatState = ref.watch(freelyTalkChatStateNotifierProvider);
    final isListening = freelyTalkChatState.isListening;

    // Handle errors (showing a SnackBar for simplicity)
    if (freelyTalkChatState.error != null && !freelyTalkChatState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(freelyTalkChatState.error!)),
        );
      });
    }

    if (freelyTalkChatState.currentSpokenWord.isNotEmpty) {
      // Calling scrollToLastWord after a delay to allow the UI to build
      Future.delayed(Duration.zero, () => scrollToLastWord());
    }

    PreferredSizeWidget appBar() {
      return AppBar(
          backgroundColor: neutralOneAlt,
          shape: Border(bottom: BorderSide(color: primary, width: 1)),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: earieBlack),
            onPressed: () {
              ref
                  .read(homeStateNotifierProvider.notifier)
                  .updateChatRoomsBasedOnSelection('Talking');
              ref.read(routerProvider).goNamed('home');
            },
          ),
          centerTitle: true,
          title: Text(
            "Talk with Elara",
            style: getSansFranciscoSemiBold20(color: earieBlack),
          ));
    }

    Widget buildMessages(ElaraResponse message) {
      final userState = ref.watch(freelyTalkChatStateNotifierProvider);
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

    return Scaffold(
      backgroundColor: neutralOneAlt,
      appBar: appBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        if (freelyTalkChatState.currentSpokenWord.isNotEmpty)
          SizedBox(
            height: 120,
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      neutralOneAlt.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  )),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    reverse: true,
                    child: Text(
                      freelyTalkChatState.currentSpokenWord,
                      style: getSansFranciscoMedium20(color: earieBlack),
                    ),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 140),
        // chatSpace()
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: AvatarGlow(
          animate: isListening,
          glowColor: primary,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          child: GestureDetector(
            onTap: () {
              // Check connectivity at the moment of the button press
              ref
                  .read(globalStateNotifierProvider.notifier)
                  .checkInternetConnection()
                  .then((_) {
                final globalState = ref.read(globalStateNotifierProvider);

                if (globalState.hasInternetConnection == false) {
                  // If offline, navigate to NetworkErrorScreen directly
                  ref.read(routerProvider).goNamed('network-error', extra: {
                    'routeName': 'talk-freely-detail',
                    'chatRoomId': widget
                        .chatRoomId, // Ensure you have access to chatRoomId in this context
                  });
                } else {
                  // If online, toggle listening state
                  if (isListening) {
                    ref
                        .read(freelyTalkChatStateNotifierProvider.notifier)
                        .stopListening();
                  } else {
                    ref
                        .read(freelyTalkChatStateNotifierProvider.notifier)
                        .startListening();
                  }
                }
              }).catchError((error) {
                // Handle any errors that occur during the connectivity check
                log('Error checking internet connection: $error');
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Icon(
                freelyTalkChatState.isListening ? Icons.mic : Icons.mic_off,
                color: earieBlack,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
