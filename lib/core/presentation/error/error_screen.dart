import 'dart:developer';

import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/global_state_notifier.dart';

class ErrorScreen extends ConsumerStatefulWidget {
  final String routeName;
  final String? chatRoomId;

  const ErrorScreen({super.key, required this.routeName, this.chatRoomId});

  @override
  ConsumerState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends ConsumerState<ErrorScreen> {
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
                    'assets/images/common_error.png',
                    width: 320,
                    height: 320,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Error!',
                    style: getSansFranciscoSemiBold32(color: neutralFour),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'We\'ve hit a snag, but we’re on it. \n In the meantime, please try refreshing.',
                      style: getSansFranciscoMedium18(color: silverFoil),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  onPressed: () {
                    // Check if the widget is still mounted before trying to interact with the context
                    if (!mounted) return;
                    log('ErrorScreen: onPressed: routeName: ${widget.routeName}');
                    ref.read(globalStateNotifierProvider.notifier).goBack();
                  },
                  child: Text(
                    'Try Again',
                    style: getSansFranciscoBold16(color: neutralFour),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
