import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/jersey_detail/liverpool_detail_page.dart';

import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart';

class Liverpool extends StatelessWidget {
  const Liverpool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liverpool',
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
                  'assets/images/poolh.png',
                  'Rs:2000',
                  'Rs:1800',
                ),
                _buildCategoryItem(
                  context,
                  'Away Jersey',
                  'assets/images/poola.png',
                  'Rs:2000',
                  'Rs:1800',
                ),
                _buildCategoryItem(
                  context,
                  'Third Jersey',
                  'assets/images/poolt.png',
                  'Rs:2000',
                  'Rs:1800',
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
            builder: (context) => LiverpoolDetailPage(
              imageUrl: imagePath,
              productName: title,
              price: discountedPrice,
              originalPrice: originalPrice,
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
                ),
              ),
              SizedBox(height: 12),
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final parsedPrice = double.tryParse(
                            discountedPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
                          ) ??
                          0.0;

                      CartModel.addToCart(
                        CartItem(
                          title: title,
                          imagePath: imagePath,
                          price: parsedPrice,
                        ),
                      );

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
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
