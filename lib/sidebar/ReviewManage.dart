import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ManageReviewsPage extends StatefulWidget {
  const ManageReviewsPage({Key? key}) : super(key: key);

  @override
  _ManageReviewsPageState createState() => _ManageReviewsPageState();
}

class _ManageReviewsPageState extends State<ManageReviewsPage> {
  final List<Map<String, dynamic>> reviews = [
    {
      "reviewer": "Norhane",
      "rating": 4.5,
      "review": "Great food and ambiance!",
      "restaurant": "Magic House",
      "date": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "reviewer": "norhane tani",
      "rating": 3.0,
      "review": "Decent experience, but service was slow.",
      "restaurant": "Pizza Hut",
      "date": DateTime.now().subtract(Duration(days: 3)),
    },
    {
      "reviewer": "Minhee",
      "rating": 1.0,
        "review": "Awful food! Highly unrecommend.",
      "restaurant": "Magic House",
      "date": DateTime.now().subtract(Duration(days: 7)),
    },
  ];

  String? selectedRestaurant;
  double? minRating;

  void deleteReview(int index) {
    setState(() {
      reviews.removeAt(index);
    });
  }

  List<Map<String, dynamic>> get filteredReviews {
    return reviews.where((review) {
      final matchesRestaurant = selectedRestaurant == null ||
          review["restaurant"] == selectedRestaurant;
      final matchesRating = minRating == null || review["rating"] >= minRating!;
      return matchesRestaurant && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        title: Text(
          'Manage Reviews',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                if (value == "4+ Stars") {
                  minRating = 4.0;
                } else {
                  minRating = null;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "All", child: Text("All Reviews")),
              const PopupMenuItem(value: "4+ Stars", child: Text("4+ Stars")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text("Filter by Restaurant", style: GoogleFonts.poppins()),
            value: selectedRestaurant,
            onChanged: (value) {
              setState(() {
                selectedRestaurant = value;
              });
            },
            items: reviews
                .map<String>((review) => review["restaurant"] as String)
                .toSet()
                .map<DropdownMenuItem<String>>((restaurant) => DropdownMenuItem<String>(
              value: restaurant,
              child: Text(restaurant, style: GoogleFonts.poppins()),
            ))
                .toList(),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "${review["reviewer"]} - ${review["restaurant"]}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: review["rating"],
                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                          itemSize: 20.0,
                        ),
                        Text(
                          review["review"],
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          "Date: ${review["date"].toString().split(" ")[0]}",
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteReview(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
