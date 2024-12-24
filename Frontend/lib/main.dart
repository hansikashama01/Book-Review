import 'package:flutter/material.dart';
import 'screens/book_review_page.dart';

void main() {
  runApp(BookReviewApp());
}

class BookReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hansika\'s Book Reviews',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookReviewPage(),
    );
  }
}
