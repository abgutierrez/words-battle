class Word {
  int? userId;
  int? id;
  final String value;

  Word({
    this.userId,
    this.id,
    required this.value,
  });

  factory Word.empty() {
    return Word(
      value: '',
    );
  }
  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      value: json['body']['Word'],
    );
  }
}
