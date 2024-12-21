import 'package:flutter/material.dart';
import 'package:recipieapp/pages/app_drawer.dart';
import 'package:recipieapp/pages/profile_screen.dart';
import 'package:recipieapp/pages/settings_screen.dart';
import 'cart_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Data for the food categories (Pizza, Burger, Pasta)
  final Map<String, List<Map<String, String>>> foodItems = {
    'Pizza': [
      {'image': 'images/pizza1.jpg', 'name': 'Pizza Margherita', 'price': '₹300'},
      {'image': 'images/pizza2.jpg', 'name': 'Pepperoni Pizza', 'price': '₹350'},
    ],
    'Burger': [
      {'image': 'images/burger1.jpg', 'name': 'Cheese Burger', 'price': '₹150'},
      {'image': 'images/burger2.jpg', 'name': 'Veggie Burger', 'price': '₹130'},
    ],
    'Pasta': [
      {'image': 'images/pasta1.jpg', 'name': 'Pasta Alfredo', 'price': '₹250'},
      {'image': 'images/pasta2.jpg', 'name': 'Pasta Marinara', 'price': '₹270'},
    ]
  };

  String selectedCategory = 'All';
  List<Map<String, String>> cartItems = [];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> allItems = [
      ...foodItems['Pizza']!,
      ...foodItems['Burger']!,
      ...foodItems['Pasta']!,
    ];

    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildBody(allItems),
      bottomNavigationBar: _buildModernBottomNavigationBar(),
    );
  }

    PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
         decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
       
      ),
    );
  }

  Widget _buildBody(List<Map<String, String>> allItems) {
    if (_selectedIndex == 0) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 20.0),
                // Food Category Buttons
                _buildCategoryButtons(),
                const SizedBox(height: 20.0),
                // Display food items grid
                _buildFoodItemsGrid(selectedCategory == 'All'
                    ? allItems
                    : foodItems[selectedCategory] ?? []),
                 const SizedBox(height: 30.0),
                 _buildTopFoodDetails(allItems),
                 const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      return CartScreen(cartItems: cartItems, removeFromCart: _removeFromCart);
    } else {
      return const SettingsScreen();
    }
  }

  // Function to build the header section
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              // TODO: Implement menu action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppDrawer())
                 );
            },
            icon: const Icon(
              Icons.menu,
              size: 35.0,
            )),
        GestureDetector(
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "images/boy.png",
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // Function to build the category buttons row
  Widget _buildCategoryButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          categoryButton('All', Icons.fastfood),
          const SizedBox(width: 10.0),
          categoryButton('Pizza', Icons.local_pizza),
          const SizedBox(width: 10.0),
          categoryButton('Burger', Icons.local_dining),
          const SizedBox(width: 10.0),
          categoryButton('Pasta', Icons.local_restaurant),
        ],
      ),
    );
  }

  // Function to build the food item grid
  Widget _buildFoodItemsGrid(List<Map<String, String>> items) {
    if (items.isEmpty) {
      return const Center(child: Text("No Items in This Category!"));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8, 
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return _buildFoodCard(item);
      },
    );
  }

  // Function to build each food card
  Widget _buildFoodCard(Map<String, String> item) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () => _showItemDetails(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: ${item['price']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      IconButton(
                          onPressed: () => _addToCart(item),
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build top food details section
  Widget _buildTopFoodDetails(List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Food Details",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
           height: 250.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index){
                return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: SizedBox(
                  width: 200.0, // or your desired width
                   child: _buildFoodCard(items[index]),
                   )
                  );
            }
          ),
        )
      ],
    );
  }

  // A button to select a food category
  Widget categoryButton(String category, IconData icon) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]
                : null),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 24.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Bottom navigation bar
   Widget _buildModernBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
           showUnselectedLabels: true,
          backgroundColor: Colors.white, 
           type: BottomNavigationBarType.fixed, 
        ),
      ),
    );
  }

  // Handler for bottom navigation bar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(Map<String, String> item) {
    setState(() {
      cartItems.add(item);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${item['name']} Added to Cart!")));
  }


  void _removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Item Removed from cart!")));
  }

  void _showItemDetails(Map<String, String> item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(item['name']!),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Price: ${item['price']}"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"))
            ],
          );
        });
  }
}