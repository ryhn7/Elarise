import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/feature_assistant/presentation/grammar_talk_chatroom/grammar_talk_chat_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/global/global_state_notifier.dart';
import '../../../router/router_provider.dart';
import '../../../theme/colors.dart';
import '../../../theme/style.dart';
import '../../domain/entities/elara_response.dart';
import '../home/home_state_notifier.dart';

class GrammarTalkChatroomScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  final bool isNewChatRoom;

  const GrammarTalkChatroomScreen(this.chatRoomId,
      {super.key, this.isNewChatRoom = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrammarTalkChatroomScreenState();
}

class _GrammarTalkChatroomScreenState
    extends ConsumerState<GrammarTalkChatroomScreen> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController editMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(grammarTalkChatStateNotifierProvider.notifier);
    notifier.chatRoomId = widget.chatRoomId;

    if (widget.isNewChatRoom) {
      // If it's a new chat room, clear any previous chat state
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.clearChat();
      });
    } else {
      // Otherwise, fetch the chat history for the given chatRoomId
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.fetchChatHistory();
      });
    }

// Clear the chat when entering a new room

    log(widget.chatRoomId);
  }

  void sendMessage(String text) {
    final messageText = messageController.text.trim();
    // Instead of using the globalState directly, check connectivity at the moment of sending
    // This ensures the latest state of the connection is used
    ref
        .read(globalStateNotifierProvider.notifier)
        .checkInternetConnection()
        .then((_) {
      final globalState = ref.read(globalStateNotifierProvider);

      if (messageText.isNotEmpty) {
        if (globalState.hasInternetConnection == false) {
          // Instead of using WidgetsBinding.instance.addPostFrameCallback, directly navigate to the error screen
          // This ensures the navigation happens immediately without waiting for the next frame
          ref.read(routerProvider).goNamed('network-error', extra: {
            'routeName': 'grammar-talk-detail',
            'chatRoomId': widget.chatRoomId,
          });
        } else {
          ref
              .read(grammarTalkChatStateNotifierProvider.notifier)
              .sendMessage(text);
          messageController.clear();

          // Also reset the typing state
          ref
              .read(grammarTalkChatStateNotifierProvider.notifier)
              .updateTypingState(false);
        }
      }
    }).catchError((error) {
      // Handle any errors that occur during the connectivity check
      log('Error checking internet connection: $error');
    });
  }

  void enableContextualAppBar(String idMessage, String userMessage) {
    final grammarTalkChatState =
        ref.read(grammarTalkChatStateNotifierProvider.notifier);

    grammarTalkChatState.enableContextualAppBar(idMessage, userMessage);
    grammarTalkChatState.highlightMessage(idMessage);
  }

  void disableContextualAppBar() {
    final grammarTalkChatState =
        ref.read(grammarTalkChatStateNotifierProvider.notifier);

    grammarTalkChatState.disableContextualAppBar();
    grammarTalkChatState.clearMessageHighlight();
  }

  void _showEditChat(
      BuildContext context, String idMessage, String userMessage) {
    editMessageController.text = userMessage;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: neutralOneAlt,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Dialog box radius
          ),
          title: Text(
            'Edit Chat',
            style: getSansFranciscoBold20(color: earieBlack),
          ),
          content: TextField(
            controller: editMessageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: getSansFranciscoMedium16(color: earieBlack),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text(
                'Edit',
                style: getSansFranciscoMedium16(
                    color: ufoGreen), // Use your primary color
              ),
              onPressed: () {
                // Implement renaming logic here
                // Make sure to validate the input before processing
                if (editMessageController.text.isNotEmpty) {
                  ref
                      .read(grammarTalkChatStateNotifierProvider.notifier)
                      .editChat(idMessage, editMessageController.text);
                }
                Navigator.of(context)
                    .pop(); // Dismiss the dialog after renaming
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditOrDeleteOption(BuildContext context) {
    final grammarTalkChatState =
        ref.watch(grammarTalkChatStateNotifierProvider);
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      color: neutralOneAlt,
      items: [
        PopupMenuItem(
          child: ListTile(
            title: Text(
              'Edit Chat',
              style: getSansFranciscoMedium16(color: earieBlack),
            ),
            onTap: () {
              // Close the modal first
              Navigator.pop(context);

              // Show the edit dialog
              _showEditChat(context, grammarTalkChatState.selectedMessageId,
                  grammarTalkChatState.selectedUserMessage);

              disableContextualAppBar();
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text(
              'Delete',
              style: getSansFranciscoMedium16(color: red),
            ),
            onTap: () {
              ref
                  .read(grammarTalkChatStateNotifierProvider.notifier)
                  .deleteChat(grammarTalkChatState.selectedMessageId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Chat deleted"),
                    duration: Duration(seconds: 2)),
              );
              Navigator.of(context).pop(); // Dismiss the dialog after deletion
              disableContextualAppBar();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the grammarTalkChatState
    final grammarTalkChatState =
        ref.watch(grammarTalkChatStateNotifierProvider);

    if (grammarTalkChatState.error != null && !grammarTalkChatState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(routerProvider).goNamed('common-error', extra: {
          'routeName': 'grammar-talk-detail',
          'chatRoomId': widget.chatRoomId,
        });
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
      final grammarTalkChatState =
          ref.watch(grammarTalkChatStateNotifierProvider);
      if (grammarTalkChatState.isContextualAppBarEnabled) {
        return AppBar(
          backgroundColor: neutralOneAlt,
          shape: Border(bottom: BorderSide(color: primary, width: 1)),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: earieBlack),
            onPressed: disableContextualAppBar,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: earieBlack),
              onPressed: () {
                _showEditOrDeleteOption(context);
              },
            ),
          ],
        );
      } else {
        return AppBar(
          backgroundColor: neutralOneAlt,
          shape: Border(bottom: BorderSide(color: primary, width: 1)),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: earieBlack),
            onPressed: () {
              ref
                  .read(homeStateNotifierProvider.notifier)
                  .updateChatRoomsBasedOnSelection('Grammar');
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
    }

    Widget buildMessages(ElaraResponse message) {
      final userState = ref.watch(grammarTalkChatStateNotifierProvider);
      final fullName = userState.userPreferences?.name ?? "User";
      final userName = fullName.split(" ")[0];
      final isHighlighted = userState.highlightedMessageId ==
          userState.userMessageIds[message.message];

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
        return GestureDetector(
          onLongPress: () {
            if (isUserMessage) {
              final userMessageId = userState.userMessageIds[message.message];

              enableContextualAppBar(userMessageId!, message.message);
              log("idUser: $userMessageId");
              log("userMessage: ${message.message}");
            }
          },
          child: Container(
            margin: isHighlighted
                ? EdgeInsets.only(
                    top: isUserMessage
                        ? 40
                        : 12, // Keep the top margin as it was
                    right: 0, // Remove right margin when highlighted
                    left: 0, // Remove left margin when highlighted
                  )
                : EdgeInsets.only(
                    top: isUserMessage ? 40 : 12,
                    right: 16,
                    left: 16,
                  ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: isHighlighted ? 16 : 0),
                  child: Row(
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
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: isUserMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.only(right: isHighlighted ? 16 : 0),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isUserMessage ? blackOlive : primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                            message.message,
                            style: getSansFranciscoRegular16(
                              color: isUserMessage ? Colors.white : earieBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isHighlighted)
                      // Overlay that covers the entire Stack
                      Positioned.fill(
                          child: Container(
                              decoration: BoxDecoration(
                        color: primary.withOpacity(0.5),
                      ))),
                  ],
                )
              ],
            ),
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
                              // Check connectivity at the moment of the button press
                              ref
                                  .read(globalStateNotifierProvider.notifier)
                                  .checkInternetConnection()
                                  .then((_) {
                                final globalState =
                                    ref.read(globalStateNotifierProvider);

                                if (globalState.hasInternetConnection ==
                                    false) {
                                  // If offline, navigate to NetworkErrorScreen directly
                                  ref
                                      .read(routerProvider)
                                      .goNamed('network-error', extra: {
                                    'routeName': 'grammar-talk-detail',
                                    'chatRoomId': widget
                                        .chatRoomId, // Ensure you have access to chatRoomId in this context
                                  });
                                } else {
                                  // If online, toggle listening state
                                  if (grammarTalkChatState.isListening) {
                                    ref
                                        .read(
                                            grammarTalkChatStateNotifierProvider
                                                .notifier)
                                        .stopListening();
                                  } else {
                                    ref
                                        .read(
                                            grammarTalkChatStateNotifierProvider
                                                .notifier)
                                        .startListening();
                                  }
                                }
                              }).catchError((error) {
                                // Handle any errors that occur during the connectivity check
                                log('Error checking internet connection: $error');
                              });
                            },
                            icon: Icon(
                              grammarTalkChatState.isSpeaking
                                  ? Icons.mic
                                  : Icons.mic_off,
                              color: Colors.black,
                              size: 32,
                            ),
                          ),
                  ))
                ],
              )
            ],
          ));
    }

    return GestureDetector(
      onTap: () {
        // Hide the keyboard when the user taps outside of the TextField
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
      ),
    );
  }
}
