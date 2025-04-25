import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/arsenal.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/barcelona.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/bayern.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/liverpool.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/madrid.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/mancity.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/manunuted.dart';
import 'package:goal_diggers/src/feature/home/presentation/team_jersey/psg.dart';

class JerseyPage extends StatefulWidget {
  const JerseyPage({super.key});

  @override
  _JerseyPageState createState() => _JerseyPageState();
}

class _JerseyPageState extends State<JerseyPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> _jerseyList = [
    {'title': 'Man United', 'image': 'assets/images/manul.png', 'page': Manunuted()},
    {'title': 'Real Madrid', 'image': 'assets/images/reall.png', 'page': Madrid()},
    {'title': 'Barcelona', 'image': 'assets/images/barcal.png', 'page': Barcelona()},
    {'title': 'Arsenal', 'image': 'assets/images/arsenall.png', 'page': Arsenal()},
    {'title': 'Man City', 'image': 'assets/images/shittyl.png', 'page': Mancity()},
    {'title': 'Liverpool', 'image': 'assets/images/liverl.png', 'page': Liverpool()},
    {'title': 'Bayern Munich', 'image': 'assets/images/bayernl.png', 'page': Bayern()},
    {'title': 'PSG', 'image': 'assets/images/psgl.png', 'page': Psg()},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = _jerseyList
        .where((jersey) => jersey['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search, color: Colors.black54),
              border: InputBorder.none,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'Football Clubs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1,
                padding: const EdgeInsets.all(10),
                children: filteredList.map((jersey) {
                  return _buildCategoryItem(
                    context, jersey['title'], jersey['image'], jersey['page'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: title,
              child: Image.asset(
                imagePath,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
