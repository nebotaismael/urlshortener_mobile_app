import '../models/shortener.dart';

class UrlState {
  final List<Url> urls;
  final bool isLoading;
  final String? error;

  UrlState({
    required this.urls,
    required this.isLoading,
    this.error,
  });


  UrlState copyWith({
    List<Url>? urls,
    bool? isLoading,
    String? error,
  }) {
    return UrlState(
      urls: urls ?? this.urls,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}