import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/socks_product_detail_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart';

class SocksPage extends StatelessWidget {
  const SocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football Socks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 180, 201, 237),
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                    "..Football..",
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
              children: [
                _buildCategoryItem(context, "Nike", "assets/images/noimage.png",
                    "Rs 180", "Rs 200"),
                _buildCategoryItem(context, "Adidas",
                    "assets/images/noimage.png", "Rs 250", "Rs 300"),
                _buildCategoryItem(context, "Puma", "assets/images/noimage.png",
                    "Rs 120", "Rs 200"),
                _buildCategoryItem(context, "Manchester United",
                    "assets/images/noimage.png", "Rs 200", "Rs 300"),
                _buildCategoryItem(context, "Real Madrid",
                    "assets/images/noimage.png", "Rs 200", "Rs 300"),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title,
      String imagePath, String discountedPrice, String originalPrice) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SocksProductDetailPage(
              imageUrl: imagePath,
              productName: title,
              price: double.parse(discountedPrice.replaceAll('Rs ', '')),
              originalPrice: double.parse(originalPrice.replaceAll('Rs ', '')),
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
                    offset: const Offset(0, 4))
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Divider(
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
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      discountedPrice,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add to Cart functionality
                        CartModel.addToCart(
                          CartItem(
                            title: title,
                            imagePath: imagePath,
                            price: double.parse(
                                discountedPrice.replaceAll('Rs ', '')),
                          ),
                        );

                        // Show Snackbar confirming the item was added to the cart
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Center(
                            child: Text(
                              'Added to cart..',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
