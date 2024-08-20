import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> shoppingList;
  final Function findShortestPath;

  const CartPage(this.shoppingList, this.findShortestPath, {super.key, required List<Map<String, dynamic>> productList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: shoppingList.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            )
                : ListView.builder(
              itemCount: shoppingList.length,
              itemBuilder: (context, index) {
                final item = shoppingList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent[100],
                      radius: 30,
                      child: Icon(item['icon'], color: Colors.blueAccent),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity: ${item['quantity']}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'You might also like:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        _buildRecommendations(item['recommendedItems']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (shoppingList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Call the findShortestPath function to calculate and navigate
                    findShortestPath();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8.0,
                  ),
                  child: const Text(
                    'Let\'s Shop!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(List<Map<String, dynamic>> recommendations) {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          return Container(
            width: 110,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: 1.1,
                  duration: const Duration(milliseconds: 300),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent[100],
                    radius: 28.0,
                    child: Icon(recommendation['icon'], color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  recommendation['name'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
