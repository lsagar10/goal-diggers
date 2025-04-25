import 'package:flutter/material.dart';
import 'package:goal_diggers/src/feature/home/presentation/product_detail/boot_product_detail_page.dart';
import 'package:goal_diggers/src/feature/home/presentation/sections/model/cart_model.dart'; // Import CartModel

class BootPage extends StatelessWidget {
  const BootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Boots Collection',
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            _buildSectionTitle('Football Boots'),
            _buildBootsList(context, footballBoots),
            const SizedBox(height: 20),
            _buildSectionTitle('Futsal Boots'),
            _buildBootsList(context, futsalBoots),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBootsList(
      BuildContext context, List<Map<String, String>> boots) {
    return Column(
      children: boots
          .map((boot) => _buildBootItem(context, boot['name']!, boot['image']!,
              boot['price']!, boot['originalPrice']!))
          .toList(),
    );
  }

  Widget _buildBootItem(BuildContext context, String title, String imagePath,
      String discountedPrice, String originalPrice) {
    return GestureDetector(
      onTap: () {
        // Navigate to the BootProductDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BootProductDetailPage(
              imageUrl: imagePath,
              productName: title,
              price: double.parse(discountedPrice.replaceAll('Rs:', '').trim()),
              originalPrice:
                  double.parse(originalPrice.replaceAll('Rs:', '').trim()),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Image.asset(imagePath, height: 150, fit: BoxFit.contain),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  const SizedBox(width: 8),
                  Text(
                    discountedPrice,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add item to cart
                CartModel.addToCart(
                  CartItem(
                    title: title,
                    imagePath: imagePath,
                    price: double.parse(
                        discountedPrice.replaceAll('Rs:', '').trim()),
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
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> footballBoots = [
  {
    'name': 'Nike Mercurial',
    'image': 'assets/images/nike_mercurial.png',
    'price': 'Rs:2500',
    'originalPrice': 'Rs:3000'
  },
  {
    'name': 'Adidas Predator',
    'image': 'assets/images/adidas_predator.png',
    'price': 'Rs:2300',
    'originalPrice': 'Rs:2800'
  },
  {
    'name': 'Puma Future',
    'image': 'assets/images/puma_future.png',
    'price': 'Rs:2200',
    'originalPrice': 'Rs:2700'
  },
  {
    'name': 'New Balance Tekela',
    'image': 'assets/images/nb_tekela.png',
    'price': 'Rs:2400',
    'originalPrice': 'Rs:2900'
  },
];

final List<Map<String, String>> futsalBoots = [
  {
    'name': 'Nike React Gato',
    'image': 'assets/images/nike_gato.png',
    'price': 'Rs:1800',
    'originalPrice': 'Rs:2200'
  },
  {
    'name': 'Adidas Copa Indoor',
    'image': 'assets/images/adidas_copa.png',
    'price': 'Rs:2000',
    'originalPrice': 'Rs:2400'
  },
  {
    'name': 'Puma King IT',
    'image': 'assets/images/puma_king.png',
    'price': 'Rs:1900',
    'originalPrice': 'Rs:2300'
  },
  {
    'name': 'Joma Top Flex',
    'image': 'assets/images/joma_topflex.png',
    'price': 'Rs:1700',
    'originalPrice': 'Rs:2100'
  },
];
