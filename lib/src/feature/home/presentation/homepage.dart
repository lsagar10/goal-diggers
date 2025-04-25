import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/cart_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/home_content.dart';
import 'package:goal_diggers/src/feature/home/presentation/profile_page.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  int? indexnum;
  Homepage({super.key, this.indexnum});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;
  // ignore: unused_field
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _pages = [
    HomeContent(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = widget.indexnum == null ? 0 : widget.indexnum;
    return Scaffold(
      
      body: _pages[selectedIndex ?? 0],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTap,
        currentIndex: selectedIndex ?? 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

 

 
  void _onItemTap(int value) {
    setState(() {
      widget.indexnum = value;
    });
  }
}
