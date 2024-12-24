class Book {
  final String id; // Ensure you have an ID field for editing/deleting
  final String title;
  final String author;
  final int rating;
  final String review;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.review,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'], // Match your backend's ID key
      title: json['title'],
      author: json['author'],
      rating: json['rating'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'rating': rating,
      'review': review,
    };
  }
}
