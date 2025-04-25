import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/track_product_detail_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart'; // Import CartModel

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track-suits',
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
                _buildCategoryItem(context, "Manchester United",
                    "assets/images/manuset1.png", "Rs 6000", "Rs 8000"),
                _buildCategoryItem(context, "Manchester United",
                    "assets/images/manuset2.png", "Rs 6000", "Rs 8000"),
                _buildCategoryItem(context, "Manchester United",
                    "assets/images/manuset3.png", "Rs 6000", "Rs 8000"),
                _buildCategoryItem(context, "Real Madrid",
                    "assets/images/realset1.png", "Rs 3000", "Rs 5000"),
                _buildCategoryItem(context, "Real Madrid",
                    "assets/images/realset2.png", "Rs 2000", "Rs 4000"),
                _buildCategoryItem(context, "Barcelona",
                    "assets/images/barcaset.png", "Rs 2000", "Rs 3000"),
                _buildCategoryItem(context, "Manchester shitty",
                    "assets/images/shittyset.png", "Rs 3000", "Rs 3200"),
                _buildCategoryItem(context, "Liverpool",
                    "assets/images/poolset.png", "Rs 150", "Rs 200"),
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
        // Navigate to ProductDetailPage when the item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrackProductDetailPage(
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
              Image.asset(
                imagePath,
                height: 150,
                fit: BoxFit.contain,
              ),
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
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add item to cart
                    CartModel.addToCart(
                      CartItem(
                        title: title,
                        imagePath: imagePath,
                        price:
                            double.parse(discountedPrice.replaceAll('Rs ', '')),
                      ),
                    );

                    // Show a SnackBar confirming the product was added to the cart
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
