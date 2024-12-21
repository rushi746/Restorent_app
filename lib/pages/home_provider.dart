// lib/features/home/presentation/state/home_provider.dart
import 'package:flutter/material.dart';
import 'package:recipieapp/pages/food_item.dart';

class HomeProvider extends ChangeNotifier{
  String _selectedCategory = 'All';
  List<FoodItem> _cartItems = [];
  int _selectedIndex = 0;
  List<FoodItem> _allItems = [];
  List<FoodItem> _favoriteItems = [];
  String _searchQuery = '';

  HomeProvider(){
  }

  String get selectedCategory => _selectedCategory;
  List<FoodItem> get cartItems => _cartItems;
  int get selectedIndex => _selectedIndex;
  List<FoodItem> get allItems => _allItems;
  List<FoodItem> get favoriteItems => _favoriteItems;
  String get searchQuery => _searchQuery;

  void setCategory(String category){
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
   void setSearchQuery(String query) {
     _searchQuery = query;
     notifyListeners();
   }

  void addToCart(FoodItem item){
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  
  void toggleFavorite(FoodItem item) {
    if (_favoriteItems.contains(item)) {
      _favoriteItems.remove(item);
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }
}