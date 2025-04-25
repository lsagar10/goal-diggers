import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/ball_product_detail_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart'; // Import CartModel

class BallPage extends StatelessWidget {
  const BallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
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
                _buildCategoryItem(context, "Mr Yod", "assets/images/mryod.png",
                    "Rs 1000", "Rs 500"),
                _buildCategoryItem(context, "Molten",
                    "assets/images/molten.png", "Rs 3000", "Rs 2000"),
                _buildCategoryItem(context, "Premeir League Ball",
                    "assets/images/pl.png", "Rs 5000", "Rs 4000"),
                _buildCategoryItem(context, "Champians League Ball",
                    "assets/images/cl.png", "Rs 5000", "Rs 4500"),
                _buildCategoryItem(context, "Europa League Ball",
                    "assets/images/uel.png", "Rs 4000", "Rs 3000"),
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
                builder: (context) => BallProductDetailPage(
                    imageUrl: imagePath,
                    productName: title,
                    price: double.parse(discountedPrice.replaceAll('Rs', '')),
                    originalPrice:
                        double.parse(discountedPrice.replaceAll('Rs', '')))));
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
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      discountedPrice,
                      style: TextStyle(
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
                    // Create a CartItem and add it to the cart
                    CartModel.addToCart(
                      CartItem(
                        title: title,
                        imagePath: imagePath,
                        price:
                            double.parse(discountedPrice.replaceAll('Rs ', '')),
                      ),
                    );

                    // Show a Snackbar confirming the product was added
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
                      ),
                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
