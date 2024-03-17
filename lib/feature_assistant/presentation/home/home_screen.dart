import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/core/utils/date_util.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state_notifier.dart';
import 'package:elarise/feature_assistant/presentation/home/widget/chatroom_card.dart';
import 'package:elarise/feature_assistant/presentation/home/widget/chatroom_loading_card.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/domain/entities/user_preferences.dart';
import '../../../feature_account_setting/presentation/account_setting/manage_account/account_state_notifier.dart';
import '../../domain/entities/get_all_talk_freely_response.dart';
import '../freely_talk_chatroom/widget/chatroom_loading_screen.dart';
import 'widget/feature_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> dropdownItems = ['Talking', 'Grammar'];
  String dropdownValue = 'Talking';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStateNotifierProvider.notifier).refreshUserPreferences();
    });

    final homeState = ref.watch(homeStateNotifierProvider);

    if (homeState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (homeState.isCreatingRoom) {
      // User is logged in, continue showing HomeScreen
      return const ChatroomLoadingScreen();
    } else if (homeState.userPreferences != null &&
        homeState.userPreferences!.token != null) {
      // User is logged in, continue showing HomeScreen
      return homeScreenContent(context, ref, homeState.userPreferences!);
    } else {
      // Handle error or no valid session
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(accountStateNotifierProvider.notifier).logout();

        ref.read(routerProvider).goNamed('login');
      });
      // Optionally, display an error message or a placeholder
      return const SizedBox.shrink();
    }
  }

  Widget homeScreenContent(
      BuildContext context, WidgetRef ref, UserPreferences userPreferences) {
    final userName = userPreferences.name ?? "User";
    final photoUrl = userPreferences.photoProfile ??
        "https://firebasestorage.googleapis.com/v0/b/elarise-1d057.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=edfb4a25-2f56-479c-9ed3-f58e90ca8ce5";
    // final token = userPreferences.token;
    // log("Token: $token");

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(routerProvider).goNamed('setting');
                      },
                      child: CachedNetworkImage(
                        imageUrl: photoUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 55,
                          height: 55,
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
                    ),
                    const SizedBox(
                      width: 14.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello,",
                            style: getSansFranciscoMedium24(color: silverFoil)),
                        SizedBox(
                          width: 200,
                          child: Text(userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getGrotesqueSemiBoldStyle24(
                                  color: neutralFour)),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset("assets/images/elarise_logo.png",
                    width: 55, height: 55),
              ]),
          const SizedBox(
            height: 12.0,
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
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Let's make every word count together",
            style: getSansFranciscoSemiBold32(color: neutralFour),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              FeatureCard(
                title: 'Talk Freely with Elara',
                description: 'Friendly talk companion',
                action: 'Just Speak',
                image: 'assets/images/sunny_img.png',
                color: ufoGreen,
                fontColor: Colors.white,
                onTap: () {
                  ref
                      .read(homeStateNotifierProvider.notifier)
                      .createFreelyTalkRoom();
                },
              ),
              const SizedBox(
                width: 16,
              ),
              FeatureCard(
                title: 'Elara Grammar Guru',
                description: 'Improve as you interact',
                action: 'Grammarize Me',
                image: 'assets/images/wind_img.png',
                color: thistle,
                fontColor: Colors.black,
                onTap: () {
                  ref
                      .read(homeStateNotifierProvider.notifier)
                      .createGrammarTalkRoom();
                },
              ),
            ],
          ),
        ],
      );
    }

    Widget buildChatRoomCard(TalkFreelyChatRoom chatRoom, int index) {
      final relativeTime = DateUtil().formatDateTime(chatRoom.createdAt);

      return ChatRoomCard(
        chatRoomName: chatRoom.chatRoomName,
        latestResponse: chatRoom.lastAIMessageText ?? "No response yet",
        date: relativeTime,
        index: index,
      );
    }

    Widget buildChatRoomLoadingCard() {
      return const ChatRoomLoadingCard();
    }

    Widget headerHistory() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("History",
                  style: getSansFranciscoSemiBold24(color: neutralFour)),
              Container(
                width: 120,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: neutralOneAlt,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: neutralFour, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down, color: neutralFour),
                    elevation: 16,
                    style: getSansFranciscoMedium16(color: neutralFour),
                    onChanged: (String? newValue) {
                      // Update the state to the new value
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }

    Widget historyCard() {
      final homeState = ref.watch(homeStateNotifierProvider);

      // list of chatrooms
      final chatRooms = homeState.freelyTalkRooms ?? [];
      final isLoading = homeState.isChatRoomLoading;

      // Determine how many loading cards to show, for example, 6.
      const loadingCardCount = 6;

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (isLoading) {
              return buildChatRoomLoadingCard();
            } else {
              final chatRoom = chatRooms[index];
              return buildChatRoomCard(chatRoom, index);
            }
          },
          childCount: isLoading ? loadingCardCount : chatRooms.length,
        ),
      );
    }

    return Scaffold(
        backgroundColor: neutralOneAlt,
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: () async => ref
              .read(homeStateNotifierProvider.notifier)
              .getAllFreelyTalkRooms(),
          child: CustomScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Ensure scrollability
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: header(),
                ),
              ),
              SliverAppBar(
                backgroundColor: neutralOneAlt,
                surfaceTintColor: neutralOneAlt,
                expandedHeight: 72,
                collapsedHeight: 72,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var top = constraints.biggest.height;
                    return Padding(
                      padding: EdgeInsets.only(
                        top: top == 72 ? 0 : 24, // adjust the value accordingly
                        left: 16,
                        right: 16,
                      ),
                      child: headerHistory(),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                sliver: historyCard(),
              ),
            ],
          ),
        )));
  }
}
