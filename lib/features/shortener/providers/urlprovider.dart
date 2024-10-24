import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:urlshortener/utils/snackbar.dart';

import '../models/shortener.dart';
import '../state/url_state.dart';

final urlProvider = StateNotifierProvider<UrlNotifier, UrlState>((ref) {
  return UrlNotifier();
});

class UrlNotifier extends StateNotifier<UrlState> {
  UrlNotifier() : super(UrlState(urls: [], isLoading: false)) {
    _loadUrls();
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.shrtlnk.dev/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<void> shortenUrl(String originalUrl) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _dio.post(
        '/shorten',
        data: {'url': originalUrl},
      );

      if (response.statusCode == 200) {
        final shortenedUrl = response.data['shortenedUrl'];
        final newUrl = Url(original: originalUrl, shortened: shortenedUrl);
        state = state.copyWith(
          urls: [...state.urls, newUrl],
          isLoading: false,
        );
        _saveUrls(state.urls);
      } else {
        _handleError('Failed to shorten URL: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        _handleError(
            'Server error: ${e.response?.statusCode} ${e.response?.statusMessage}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        _handleError('Connection timeout. Please try again later.');
      } else {
        _handleError('Unexpected error: ${e.message}');
      }
    } catch (e) {
      _handleError('An unexpected error occurred: $e');
    }
  }

  Future<void> _loadUrls() async {
    final prefs = await SharedPreferences.getInstance();
    final String? urlsString = prefs.getString('urls');
    if (urlsString != null) {
      final List<dynamic> jsonList = json.decode(urlsString);
      final List<Url> urls =
          jsonList.map((json) => Url.fromJson(json)).toList();
      state = state.copyWith(urls: urls);
    }
  }

  Future<void> _saveUrls(List<Url> urls) async {
    final prefs = await SharedPreferences.getInstance();
    final String urlsString =
        json.encode(urls.map((url) => url.toJson()).toList());
    await prefs.setString('urls', urlsString);
  }

  void _handleError(String message) {
    if (kDebugMode) {
      print(message);
    }
    showSnackbar(message);
    state = state.copyWith(isLoading: false, error: message);
  }
}
