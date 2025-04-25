import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/homepage.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/boot_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/jersey_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/settings_page.dart';
import 'login_page.dart';
import 'sections/ball_page.dart';
import 'sections/retro_page.dart';
import 'sections/socks_page.dart';
import 'sections/track_page.dart';
import 'support_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];
  bool isSearching = false;

  final List<String> bannerImages = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
  ];

  final List<Widget> bannerPages = [
    Homepage(),
    BootPage(),
    JerseyPage(),
    RetroPage(),
    TrackPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadProducts() {
    // Create empty list to populate with products from all categories
    allProducts = [];

    // Function to add products from a specific category
    void addProductsFromCategory(
        String category, String imageAsset, List<String> productNames) {
      for (String name in productNames) {
        allProducts
            .add({'name': name, 'category': category, 'image': imageAsset});
      }
    }

    // Add Jersey products
    addProductsFromCategory('Jerseys', 'assets/images/jersey.png', [
      'Manchester United Jersey',
      'Real Madrid Jersey',
      'Barcelona Jersey',
      'Liverpool Jersey',
      'Bayern Munich Jersey',
      'PSG Jersey',
      'Juventus Jersey',
      'Chelsea Jersey'
    ]);

    // Add Boots products
    addProductsFromCategory('Boots', 'assets/images/boots.png', [
      'Nike Mercurial Boots',
      'Adidas Predator Boots',
      'Puma Future Boots',
      'New Balance Tekela Boots',
      'Nike Phantom GT Boots',
      'Adidas Copa Boots'
    ]);

    // Add Football products
    addProductsFromCategory('Football', 'assets/images/ball.png', [
      'Nike Premier League Ball',
      'Adidas Champions League Ball',
      'Puma Serie A Ball',
      'Nike Flight Ball',
      'Adidas World Cup Ball'
    ]);

    // Add Track products
    addProductsFromCategory('Track', 'assets/images/track.png', [
      'Adidas Training Track',
      'Nike Dri-FIT Track',
      'Puma Training Track',
      'Under Armour Track',
      'New Balance Track Suit'
    ]);

    // Add Retro Kit products
    addProductsFromCategory('Retro Kits', 'assets/images/retro.png', [
      'Arsenal 2004 Retro Kit',
      'Manchester United 1999 Retro Kit',
      'Brazil 2002 Retro Kit',
      'AC Milan 2007 Retro Kit',
      'Barcelona 2011 Retro Kit'
    ]);

    // Add Socks products
    addProductsFromCategory('Socks', 'assets/images/socks.png', [
      'Player Match Socks',
      'Nike Elite Football Socks',
      'Adidas Team Socks',
      'Puma Football Socks',
      'Under Armour Soccer Socks'
    ]);

    // Initialize filtered products with all products
    filteredProducts = List.from(allProducts);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredProducts = List.from(allProducts);
        isSearching = false;
      });
    } else {
      setState(() {
        filteredProducts = allProducts
            .where((product) =>
                product['name'].toLowerCase().contains(query) ||
                product['category'].toLowerCase().contains(query))
            .toList();
        isSearching = true;
      });
    }
  }

  Future<Map<String, String>> _getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('first_name') ?? 'User';
    String lastName = prefs.getString('last_name') ?? '';
    String email = prefs.getString('email') ?? '';
    return {'firstName': firstName, 'lastName': lastName, 'email': email};
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search, color: Colors.black54),
              border: InputBorder.none,
              // Add a clear button to reset search
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
            ),
            onSubmitted: (value) {
              // Additional logic when user presses enter
              _onSearchChanged();
            },
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Drawer(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final firstName = snapshot.data?['firstName'] ?? 'User';
          final lastName = snapshot.data?['lastName'] ?? '';
          final email = snapshot.data?['email'] ?? '';
          return _buildDrawer(context, firstName, lastName, email);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSearching
            ? _buildSearchResults()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBannerSlider(context),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Categories',
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
                      children: [
                        _buildCategoryItem(context, 'Jerseys',
                            'assets/images/jersey.png', JerseyPage()),
                        _buildCategoryItem(context, 'Boots',
                            'assets/images/boots.png', BootPage()),
                        _buildCategoryItem(context, 'Football',
                            'assets/images/ball.png', BallPage()),
                        _buildCategoryItem(context, 'Track',
                            'assets/images/track.png', TrackPage()),
                        _buildCategoryItem(context, 'Retro Kits',
                            'assets/images/retro.png', RetroPage()),
                        _buildCategoryItem(context, 'Socks',
                            'assets/images/socks.png', SocksPage()),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              icon: Icon(Icons.close),
              label: Text('Clear'),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: Image.asset(
                    product['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(product['category']),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to product detail page
                    Widget page;
                    switch (product['category']) {
                      case 'Jerseys':
                        page = JerseyPage();
                        break;
                      case 'Boots':
                        page = BootPage();
                        break;
                      case 'Football':
                        page = BallPage();
                        break;
                      case 'Track':
                        page = TrackPage();
                        break;
                      case 'Retro Kits':
                        page = RetroPage();
                        break;
                      case 'Socks':
                        page = SocksPage();
                        break;
                      default:
                        page = Homepage();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(
      BuildContext context, String firstName, String lastName, String email) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Welcome $firstName $lastName"),
            accountEmail: Text(email),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _buildDrawerItem(Icons.person, "Profile", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Homepage(indexnum: 2)));
          }),
          _buildDrawerItem(Icons.shopping_bag, "Cart", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Homepage(indexnum: 1)));
          }),
          _buildDrawerItem(Icons.settings, "Settings", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          }),
          _buildDrawerItem(Icons.help, "Help & Support", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SupportPage()));
          }),
          const Divider(),
          _buildDrawerItem(Icons.logout, "Logout", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _buildBannerSlider(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
      items: bannerImages.asMap().entries.map((entry) {
        int index = entry.key;
        String imagePath = entry.value;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => bannerPages[index]),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
            Image.asset(imagePath, height: 90, fit: BoxFit.contain),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
