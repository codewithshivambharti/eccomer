import 'package:eccomerce_app/Login%20Screen/login.dart';
import 'package:eccomerce_app/cart/cart_screen.dart';
import 'package:flutter/material.dart';

import '../product_model.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Product> products = [
    Product('iPhone', 999.0, '📱'),
    Product('Laptop', 1299.0, '💻'),
    Product('Headphones', 249.0, '🎧'),
    Product('Watch', 399.0, '⌚'),
    Product('Tablet', 599.0, '📱'),
    Product('Speaker', 199.0, '🔊'),
  ];

  List<Product> cart = [];
  double total = 0.0;

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
      total += product.price;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${product.name} added to cart!')));
  }

  void removeFromCart(int index) {
    setState(() {
      total -= cart[index].price;
      cart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cart.length > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${cart.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cart: cart,
                    total: total,
                    onRemove: removeFromCart,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(product.emoji, style: TextStyle(fontSize: 40)),
                          SizedBox(height: 8),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () => addToCart(product),
                            child: Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 36),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
