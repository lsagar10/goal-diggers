class CartItem {
  final String title;
  final String imagePath;
  final double price;
   int quantity;

  CartItem({
    required this.title,
    required this.imagePath,
    required this.price,
     this.quantity = 1,
  });
}

class CartModel {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addToCart(CartItem item) {
    _items.add(item);
  }

  static void clearCart() {
    _items.clear();
  }

  static double getTotalPrice() {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }
}
