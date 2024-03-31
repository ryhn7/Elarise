import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});

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
                  onPressed: () {
                    // refresh the page
                  },
                  child: Text(
                    'Refresh',
                    style: getSansFranciscoBold16(color: neutralFour),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
