import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/jersey_detail/madrid_detail_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart';

class Madrid extends StatelessWidget {
  const Madrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Real Madrid',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        elevation: 5,
        shadowColor: Colors.black54,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '..Shop your fav jersey..',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(10),
              children: [
                _buildCategoryItem(
                  context,
                  'Home Jersey',
                  'assets/images/realh.png',
                  'Rs:2500',
                  'Rs:2250', // Discounted price
                ),
                _buildCategoryItem(
                  context,
                  'Away Jersey',
                  'assets/images/reala.png',
                  'Rs:2000',
                  'Rs:1800', // Discounted price
                ),
                _buildCategoryItem(
                  context,
                  'Third Jersey',
                  'assets/images/realt.png',
                  'Rs:2500',
                  'Rs:2250', // Discounted price
                ),
                _buildCategoryItem(
                  context,
                  'Concept Kit',
                  'assets/images/special1.png',
                  'Rs:3000',
                  'Rs:2700', // Discounted price
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String title,
    String imagePath,
    String originalPrice,
    String discountedPrice,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MadridDetailPage(
              imageUrl: imagePath,
              productName: title,
              price: discountedPrice, // Pass as String
              originalPrice: originalPrice, // Pass as String
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 96, 95, 95),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
                color: Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Hero(
                  tag: title,
                  child: Image.asset(
                    imagePath,
                    height: 150,
                    fit: BoxFit.contain,
                  )),
              SizedBox(height: 12),
              // Display original and discounted prices
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      discountedPrice,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Sanitize and parse price from the discountedPrice string
                      String sanitizedPrice =
                          discountedPrice.replaceAll(RegExp(r'[^\d.]'), '');
                      double price = double.parse(sanitizedPrice);

                      // Create CartItem and add to cart
                      CartItem cartItem = CartItem(
                        title: title,
                        imagePath: imagePath,
                        price: price,
                      );
                      CartModel.addToCart(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Added to cart..',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      "Add to Cart",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
