import 'package:flutter/material.dart';

import '../product_model.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cart;
  final double total;
  final Function(int) onRemove;

  CartScreen({required this.cart, required this.total, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  Text('Cart is empty', style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      Product product = cart[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading: Text(
                            product.emoji,
                            style: TextStyle(fontSize: 32),
                          ),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              onRemove(index);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Order Placed! 🎉'),
                              content: Text(
                                'Thank you for your purchase!\nTotal: \$${total.toStringAsFixed(2)}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
