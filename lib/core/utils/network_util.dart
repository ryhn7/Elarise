import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  // Method to check if the device is connected to the internet
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.isNotEmpty && connectivityResult[0] == ConnectivityResult.none) {
      // No internet connection
      return false;
    } else {
      // Device is connected to either mobile data or WiFi
      return true;
    }
  }
}