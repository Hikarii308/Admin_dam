import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ManageRestaurantsPage extends StatefulWidget {
  const ManageRestaurantsPage({Key? key}) : super(key: key);

  @override
  _ManageRestaurantsPageState createState() => _ManageRestaurantsPageState();
}

class _ManageRestaurantsPageState extends State<ManageRestaurantsPage> {
  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Magic House",
      "region": "Constantine",
      "description": "A cozy place for family dining.",
      "image": "https://via.placeholder.com/150",
      "rating": 4.5
    },
    {
      "name": "Pizza Hut",
      "region": "Setif",
      "description": "Serving the best pizzas in town!",
      "image": "https://via.placeholder.com/150",
      "rating": 4.0
    }
  ];

  void addRestaurant(String name, String region, String description, String image, double rating) {
    setState(() {
      restaurants.add({
        "name": name,
        "region": region,
        "description": description,
        "image": image,
        "rating": rating
      });
    });
  }

  void deleteRestaurant(int index) {
    setState(() {
      restaurants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Manage Restaurants',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant["image"],
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                restaurant["name"],
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Region: ${restaurant["region"]}',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    restaurant["description"],
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 5),
                  RatingBarIndicator(
                    rating: restaurant["rating"],
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    itemSize: 20,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteRestaurant(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE8E8E8),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              final regionController = TextEditingController();
              final descriptionController = TextEditingController();
              final imageController = TextEditingController();
              double rating = 3.0;

              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Add Restaurant',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Restaurant Name',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: regionController,
                        decoration: InputDecoration(
                          labelText: 'Region',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Rating:',
                        style: GoogleFonts.poppins(color: Colors.grey[700]),
                      ),
                      RatingBar(
                        initialRating: 3.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.amber),
                          half: const Icon(Icons.star_half, color: Colors.amber),
                          empty: const Icon(Icons.star_border, color: Colors.amber),
                        ),
                        onRatingUpdate: (newRating) {
                          rating = newRating;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          regionController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          imageController.text.isNotEmpty) {
                        addRestaurant(
                          nameController.text,
                          regionController.text,
                          descriptionController.text,
                          imageController.text,
                          rating,
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
