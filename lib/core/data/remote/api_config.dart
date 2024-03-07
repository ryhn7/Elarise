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
        }
        // Case when JSON does not contain 'data' key but decoder is provided
        else if (!jsonResult.containsKey('data') && decoder != null) {
          return decoder(jsonResult);
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
        }
        // Case when JSON does not contain 'data' key but decoder is provided
        else if (!jsonResult.containsKey('data') && decoder != null) {
          return decoder(jsonResult);
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

  // Add a method specifically for fetching binary data, such as an MP3 file
  Future<http.Response> fetchBinaryData(String path,
      {Map<String, String>? headers, Object? body}) async {
    final Map<String, String> authHeaders = {
      'Authorization': 'Bearer ${Configuration.openAIKey}',
    };

    headers?.forEach((key, value) => authHeaders[key] = value);

    try {
      final Uri uri = Uri.parse(path);
      final response = await http.post(uri, headers: authHeaders, body: body);

      alice.onHttpResponse(response);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch binary data: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString(), name: 'ApiConfig');
      throw Exception('Failed to fetch binary data');
    }
  }
}
