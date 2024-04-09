import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/global_state_notifier.dart';
import '../../utils/network_util.dart';

class NetworkErrorScreen extends ConsumerStatefulWidget {
  final String routeName;
  final String? chatRoomId;

  const NetworkErrorScreen(
      {super.key, required this.routeName, this.chatRoomId});

  @override
  ConsumerState<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends ConsumerState<NetworkErrorScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(globalStateNotifierProvider.notifier).routeName = widget.routeName;
    ref.read(globalStateNotifierProvider.notifier).chatRoomId =
        widget.chatRoomId ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: neutralOneAlt,
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Adjusted to min to wrap content
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/network_error.png',
                    width: 320,
                    height: 320,
                  ),
                  Text(
                    'Whoops!',
                    style: getSansFranciscoSemiBold32(color: neutralFour),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Looks like you\'re offline. \nPlease check your internet connection.',
                    style: getSansFranciscoMedium18(color: silverFoil),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                // make button to refresh
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    onPressed: () async {
                      final isConnected =
                          await NetworkUtil().isInternetAvailable();

                      // Check if the widget is still mounted before trying to interact with the context
                      if (!mounted) return;

                      if (isConnected) {
                        ref
                            .read(globalStateNotifierProvider.notifier)
                            .setInternetConnection(isConnected);
                        ref.read(globalStateNotifierProvider.notifier).goBack();
                      } else {
                        // The device is still offline. Show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You are still offline. Please check your internet connection.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Refresh',
                      style: getSansFranciscoBold16(color: neutralFour),
                    )),
              ),
            )
          ])),
    );
  }
}
