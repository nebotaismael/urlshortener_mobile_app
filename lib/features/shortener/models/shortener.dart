
// Model for a shortened URL
class Url {
  final String original;
  final String shortened;

  Url({required this.original, required this.shortened});


  Map<String, dynamic> toJson() => {'original': original, 'shortened': shortened};

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    original: json['original'],
    shortened: json['shortened'],
  );
}


