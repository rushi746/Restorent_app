import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  final Function(int) removeFromCart;
  const CartScreen({Key? key, required this.cartItems, required this.removeFromCart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = widget.cartItems.fold(0.0, (sum, item) {
      final priceString = item['price']?.replaceAll('₹', '');
      final price = double.tryParse(priceString ?? '0') ?? 0.0;
      return sum + price;
    });
  }
  @override
  void didUpdateWidget(covariant CartScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.cartItems != oldWidget.cartItems) {
      _calculateTotalPrice();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cartItems.isEmpty) {
      return const Center(
        child: Text("Your Cart is Empty!", style: TextStyle(fontSize: 18),),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(item['image']!, width: 60.0, height: 60.0, fit: BoxFit.cover,),
                      ),
                      title: Text(item['name']!),
                      subtitle: Text('Price: ${item['price']}'),
                      trailing: IconButton(
                        onPressed: () {
                            widget.removeFromCart(index);
                            _calculateTotalPrice();
                        },
                        icon: const Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Total Price: ₹${_totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  ElevatedButton(onPressed: () => _checkout(context), child: const Text("Checkout"),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Checkout"),
        content:  Text("Your order has been placed Successfully with total price of ₹${_totalPrice.toStringAsFixed(2)}!"),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Ok"))
        ],
      )
    );
  }
}