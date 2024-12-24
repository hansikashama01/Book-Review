import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import '../models/book.dart';
import '../widgets/review_card.dart';

class BookReviewPage extends StatefulWidget {
  @override
  _BookReviewPageState createState() => _BookReviewPageState();
}

class _BookReviewPageState extends State<BookReviewPage> {
  final String baseUrl = "http://localhost:5000/api/books"; // Update as needed
  List<Book> books = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  int rating = 3; // Default rating
  int? editIndex; // Track the review being edited

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          books = data.map((json) => Book.fromJson(json)).toList();
        });
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      _showErrorDialog("Error fetching books: $e");
    }
  }

  Future<void> addOrEditBook({String? id}) async {
    final book = Book(
      id: '', // Backend assigns ID for new books
      title: titleController.text,
      author: authorController.text,
      rating: rating,
      review: reviewController.text,
    );

    try {
      final url = id == null ? baseUrl : "$baseUrl/$id";
      final response = await (id == null
          ? http.post(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(book.toJson()),
            )
          : http.put(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(book.toJson()),
            ));

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pop(context);
        fetchBooks();
      } else {
        throw Exception("Failed to save book");
      }
    } catch (e) {
      _showErrorDialog("Error saving book: $e");
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        fetchBooks();
      } else {
        throw Exception("Failed to delete book");
      }
    } catch (e) {
      _showErrorDialog("Error deleting book: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error", style: TextStyle(color: Colors.deepPurpleAccent)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK", style: TextStyle(color: Colors.deepPurpleAccent)),
            ),
          ],
        );
      },
    );
  }

  void _showAddOrEditDialog({Book? book, int? index}) {
    if (book != null) {
      titleController.text = book.title;
      authorController.text = book.author;
      reviewController.text = book.review;
      rating = book.rating;
      editIndex = index;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? "Add New Review" : "Edit Review", style: TextStyle(color: Colors.deepPurpleAccent)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Book Title",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(
                    labelText: "Author",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text("Rating:", style: TextStyle(fontSize: 16, color: Colors.deepPurpleAccent)),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: rating,
                      items: List.generate(5, (i) => i + 1)
                          .map((e) => DropdownMenuItem(value: e, child: Text("$e Stars", style: TextStyle(color: Colors.deepPurpleAccent))))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          rating = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Review",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _clearFields();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(book == null ? "Add" : "Edit", style: TextStyle(color: Colors.deepPurpleAccent)),
              onPressed: () {
                addOrEditBook(id: book?.id);
              },
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    titleController.clear();
    authorController.clear();
    reviewController.clear();
    rating = 3;
    editIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Book Reviews",
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 10,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.deepPurple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ReviewCard(
              book: book,
              onEdit: () => _showAddOrEditDialog(book: book, index: index),
              onDelete: () => deleteBook(book.id),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOrEditDialog();
        },
        backgroundColor: Colors.transparent,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
