// lib/features/order/presentation/screens/order_history_screen.dart
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  final List<Map<String, dynamic>> _mockOrderHistory = [
    {
      'orderId': '#12345',
      'date': '2024-05-03',
      'items': ['Pizza Margherita', 'Cheese Burger'],
      'total': '₹450',
    },
    {
      'orderId': '#12346',
      'date': '2024-05-02',
      'items': ['Pasta Alfredo', 'Veggie Burger'],
      'total': '₹380',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
          itemCount: _mockOrderHistory.length,
          itemBuilder: (context, index) {
            final order = _mockOrderHistory[index];
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                title: Text('Order ID: ${order['orderId']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${order['date']}'),
                    Text('Items: ${order['items'].join(', ')}'),
                     Text('Total: ${order['total']}'),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}