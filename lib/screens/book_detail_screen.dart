import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/rating_widget.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            RatingWidget(
              rating: book.rating,
              onRatingChanged: (newRating) {
                Provider.of<BookProvider>(context, listen: false)
                    .updateBook(book.copyWith(rating: newRating));
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Read: ', style: TextStyle(fontSize: 18)),
                Switch(
                  value: book.isRead,
                  onChanged: (newValue) {
                    Provider.of<BookProvider>(context, listen: false)
                        .updateBook(book.copyWith(isRead: newValue));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
