
// import 'package:flutter/material.dart';
// import 'package:goal_diggers/src/feature/home/presentation/home_content.dart';
// import 'package:goal_diggers/src/feature/home/presentation/sections/retro_page.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   // Initialize a copy of the cart items from RetroPage
//   List<Map<String, String>> cartItems = List.from(RetroPage.cartItems);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         foregroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Your Cart',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: cartItems.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart_outlined,
//                     size: 120,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   Text(
//                     'Your Cart is Empty',
//                     style: TextStyle(fontSize: 20, color: Colors.grey),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Looks like you haven\'t added anything to your cart yet!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16))),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => HomeContent()));
//                     },
//                     child: Text('Shop now',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             cartItems[index]['image']!,
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         // Product Info Column
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Product Name
//                               Text(
//                                 cartItems[index]['name']!,
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               SizedBox(height: 8),
//                               // Product Price
//                               Text(
//                                 cartItems[index]['price']!,
//                                 style: TextStyle(fontSize: 14, color: Colors.green),
//                               ),
//                               SizedBox(height: 16),
//                               // Buttons
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                           content: Text("Item purchased: ${cartItems[index]['name']}"),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.green,
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                                     ),
//                                     child: Text("Buy Item"),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         cartItems.removeAt(index); // Remove the item from the cart
//                                       });
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                           content: Text("${cartItems[index]['name']} removed from cart"),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.redAccent,
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                                     ),
//                                     child: Text("Clear", style: TextStyle(fontSize: 12)),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// Retro
// import 'package:flutter/material.dart';
// import 'package:goal_diggers/src/feature/home/presentation/cart_page.dart';
// import 'package:goal_diggers/src/feature/home/presentation/product_detail/retro_product_detail_page.dart';

// class RetroPage extends StatelessWidget {
//   const RetroPage({super.key});

//   // List to store cart items (you can make this more sophisticated if needed)
//   static List<Map<String, String>> cartItems = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Retro-kits',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 180, 201, 237),
//         foregroundColor: Colors.white,
//         elevation: 5,
//         shadowColor: Colors.black54,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(15),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "..Football..",
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: GridView.count(
//               crossAxisCount: 1,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 1,
//               children: [
//                 _buildCategoryItem(context, "Manchester United 1999",
//                     "assets/images/manu1999.png", "Rs 4000", "Rs 5000"),
//                 _buildCategoryItem(context, "Manchester United 1996",
//                     "assets/images/manu1996.png", "Rs 4000", "Rs 5000"),
//                 _buildCategoryItem(context, "Manchester United 2006",
//                     "assets/images/manu06.png", "Rs 3000", "Rs 4000"),
//                 _buildCategoryItem(context, "Wayne Rooney",
//                     "assets/images/rooneyretro.png", "Rs 3000", "Rs 3500"),
//                 _buildCategoryItem(context, "Real Madrid 1999",
//                     "assets/images/real99.png", "Rs 4000", "Rs 5000"),
//                 _buildCategoryItem(context, "Real Madrid 2013",
//                     "assets/images/real13.png", "Rs 3000", "Rs 4000"),
//                 _buildCategoryItem(context, "barcelona 1996",
//                     "assets/images/barca1996.png", "Rs 5000", "Rs 3000"),
//                 _buildCategoryItem(context, "barcelona 2008",
//                     "assets/images/barca8.png", "Rs 5000", "Rs 2000"),
//                 _buildCategoryItem(context, "barcelona 2014",
//                     "assets/images/barca14.png", "Rs 5000", "Rs 2000"),
//                 _buildCategoryItem(context, "Manchester United 2007",
//                     "assets/images/manu07.png", "Rs 5000", "Rs 2000"),
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryItem(BuildContext context, String title,
//       String imagePath, String discountedPrice, String originalPrice) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RetroProductDetailPage(
//               imageUrl: imagePath,
//               productName: title,
//               price: double.parse(discountedPrice.replaceAll('Rs ', '')),
//               originalPrice: double.parse(originalPrice.replaceAll('Rs ', '')),
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                     color: const Color.fromARGB(255, 96, 95, 95),
//                     spreadRadius: 4,
//                     blurRadius: 6,
//                     offset: const Offset(0, 4))
//               ]),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//               const Divider(
//                 thickness: 1.0,
//                 color: Colors.grey,
//                 indent: 10.0,
//                 endIndent: 10.0,
//               ),
//               Hero(
//                   tag: title,
//                   child: Image.asset(
//                     imagePath,
//                     height: 150,
//                     fit: BoxFit.contain,
//                   )),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       originalPrice,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       discountedPrice,
//                       style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.redAccent),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Center(
//                               child: Text(
//                                 "WOOW  !!   Awesome Choice ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             backgroundColor: Colors.blueAccent,
//                             duration: Duration(seconds: 2),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 8),
//                       ),
//                       child: const Text(
//                         "Shop",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _addToCart(context, title, imagePath, discountedPrice);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 8),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "Add to Cart",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to handle the "Add to Cart" button click
//   void _addToCart(
//       BuildContext context, String itemName, String imagePath, String price) {
//     cartItems.add({
//       'name': itemName,
//       'image': imagePath,
//       'price': price,
//     });

//     // Navigate to Cart Page
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CartPage(),
//       ),
//     );
//   }
// }
