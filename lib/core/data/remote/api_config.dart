import 'dart:developer';

import 'package:elarise/core/utils/config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:alice/alice.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ApiConfig {
  Alice alice = Alice(showNotification: true, navigatorKey: navigatorKey);

  Future<T> getApiService<T>(String path,
      {Map<String, String>? headers,
      T Function(Map<String, dynamic>)? decoder}) async {
    // Add Authorization header with the token
    final Map<String, String> authHeaders = {
      'Authorization': 'Bearer ${Configuration.token}',
    };
    // Merge additional headers with authHeaders if any
    headers?.forEach((key, value) {
      authHeaders[key] = value;
    });

    try {
      final response = await http.get(
          Uri.parse('${Configuration.baseUrl}$path'),
          headers: authHeaders);
      alice.onHttpResponse(response);

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        // Check if the response contains the 'data' key and the decoder is not null
        if (jsonResult.containsKey('data') && decoder != null) {
          // Pass only the 'data' part of the JSON to the decoder function
          return decoder(jsonResult['data']);
        } else {
          throw Exception(
              'Decoder is null or response JSON does not contain \'data\' key');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString(), name: 'ApiConfig');
      throw Exception('Failed to load data');
    }
  }

  Future<T> postApiService<T>(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      T Function(Map<String, dynamic>)? decoder}) async {
    // Add Authorization header with the token
    final Map<String, String> authHeaders = {
      'Authorization': 'Bearer ${Configuration.token}',
    };
    // Merge additional headers with authHeaders if any
    headers?.forEach((key, value) {
      authHeaders[key] = value;
    });

    try {
      final response = await http.post(
          Uri.parse('${Configuration.baseUrl}$path'),
          headers: authHeaders,
          body: jsonEncode(body));
      alice.onHttpResponse(response);
      
      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        // Check if the response contains the 'data' key and the decoder is not null
        if (jsonResult.containsKey('data') && decoder != null) {
          // Pass only the 'data' part of the JSON to the decoder function
          return decoder(jsonResult['data']);
        } else {
          throw Exception(
              'Decoder is null or response JSON does not contain \'data\' key');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString(), name: 'ApiConfig');
      throw Exception('Failed to load data');
    }
  }
}