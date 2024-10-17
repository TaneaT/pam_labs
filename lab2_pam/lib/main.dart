import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(BarberShopApp());
}

class BarberShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barber Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/pics/profile.jpg'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Banner
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Joe Samanta',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Yogyakarta',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/pics/banner.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search barber’s, haircut service...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
            // Nearest Barbershops Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Nearest Barbershop',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            BarbershopList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Most recommended',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            MostRecommendedList(),
          ],
        ),
      ),
    );
  }
}

// Nearest Barbershop List
class BarbershopList extends StatefulWidget {
  @override
  _BarbershopListState createState() => _BarbershopListState();
}

class _BarbershopListState extends State<BarbershopList> {
  List<dynamic> barbershops = [];

  @override
  void initState() {
    super.initState();
    loadBarbershops();
  }

  Future<void> loadBarbershops() async {
    String data = await rootBundle.loadString('assets/barbershops.json');
    setState(() {
      barbershops = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        itemBuilder: (context, index) {
          var shop = barbershops[index];
          return BarbershopCard(
            shop['name'],
            shop['service'],
            shop['rating'],
            image: shop['image'],
          );
        },
      ),
    );
  }
}

class BarbershopCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rating;
  final String image;

  BarbershopCard(this.title, this.subtitle, this.rating, {required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(subtitle),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(rating),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MostRecommendedList extends StatefulWidget {
  @override
  _MostRecommendedListState createState() => _MostRecommendedListState();
}

class _MostRecommendedListState extends State<MostRecommendedList> {
  List<dynamic> recommendedShops = [];

  @override
  void initState() {
    super.initState();
    loadRecommendedShops();
  }

  Future<void> loadRecommendedShops() async {
    String data = await rootBundle.loadString('assets/recommended_barbershops.json');
    setState(() {
      recommendedShops = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: recommendedShops.length,
        itemBuilder: (context, index) {
          var shop = recommendedShops[index];
          return BarbershopCard(
            shop['name'],
            shop['service'],
            shop['rating'],
            image: shop['image'],
          );
        },
      ),
    );
  }
}
