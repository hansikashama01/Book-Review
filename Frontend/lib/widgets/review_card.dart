import 'package:flutter/material.dart';
import '../models/book.dart';

class ReviewCard extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ReviewCard({required this.book, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(book.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            Text(
              "${book.author} - ",
              style: TextStyle(fontSize: 14),
            ),
            // Display the star icons based on the rating
            ...List.generate(
              book.rating,
              (index) => Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
            ),
            SizedBox(width: 5),
            Text(
              book.review,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
