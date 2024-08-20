import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'cart_page.dart';
import 'path_optimization.dart';
import 'map_view.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  // Updated product list with more items
  // final List<Map<String, dynamic>> _productList = [
  //   {'name': 'Milk', 'location': {'aisle': 1, 'shelf': 1}, 'category': 'Dairy', 'icon': Icons.local_drink, 'position': const Offset(1, 1)},
  //   {'name': 'Cheese', 'location': {'aisle': 1, 'shelf': 2}, 'category': 'Dairy', 'icon': Icons.restaurant, 'position': const Offset(1, 2)},
  //   {'name': 'Butter', 'location': {'aisle': 1, 'shelf': 3}, 'category': 'Dairy', 'icon': Icons.food_bank, 'position': const Offset(1, 3)},
  //   {'name': 'Bread', 'location': {'aisle': 2, 'shelf': 1}, 'category': 'Bakery', 'icon': Icons.bakery_dining, 'position': const Offset(2, 1)},
  //   {'name': 'Cake', 'location': {'aisle': 2, 'shelf': 2}, 'category': 'Bakery', 'icon': Icons.cake, 'position': const Offset(2, 2)},
  //   {'name': 'Croissant', 'location': {'aisle': 2, 'shelf': 3}, 'category': 'Bakery', 'icon': Icons.local_cafe, 'position': const Offset(2, 3)},
  //   {'name': 'Apples', 'location': {'aisle': 3, 'shelf': 1}, 'category': 'Fruits', 'icon': Icons.apple, 'position': const Offset(3, 1)},
  //   {'name': 'Bananas', 'location': {'aisle': 3, 'shelf': 2}, 'category': 'Fruits', 'icon': Icons.local_grocery_store, 'position': const Offset(3, 2)},
  //   {'name': 'Oranges', 'location': {'aisle': 3, 'shelf': 3}, 'category': 'Fruits', 'icon': Icons.local_grocery_store, 'position': const Offset(3, 3)},
  //   {'name': 'Chicken', 'location': {'aisle': 4, 'shelf': 1}, 'category': 'Meat', 'icon': Icons.local_dining, 'position': const Offset(4, 1)},
  //   {'name': 'Beef', 'location': {'aisle': 4, 'shelf': 2}, 'category': 'Meat', 'icon': Icons.local_dining, 'position': const Offset(4, 2)},
  //   {'name': 'Fish', 'location': {'aisle': 4, 'shelf': 3}, 'category': 'Meat', 'icon': Icons.local_dining, 'position': const Offset(4, 3)},
  //   {'name': 'Juice', 'location': {'aisle': 5, 'shelf': 1}, 'category': 'Beverages', 'icon': Icons.local_drink, 'position': const Offset(5, 1)},
  //   {'name': 'Water', 'location': {'aisle': 5, 'shelf': 2}, 'category': 'Beverages', 'icon': Icons.local_drink, 'position': const Offset(5, 2)},
  //   {'name': 'Coffee', 'location': {'aisle': 5, 'shelf': 3}, 'category': 'Beverages', 'icon': Icons.coffee, 'position': const Offset(5, 3)},
  //   {'name': 'Tea', 'location': {'aisle': 5, 'shelf': 4}, 'category': 'Beverages', 'icon': Icons.local_cafe, 'position': const Offset(5, 4)},
  //   {'name': 'Rice', 'location': {'aisle': 6, 'shelf': 1}, 'category': 'Grains', 'icon': Icons.rice_bowl, 'position': const Offset(6, 1)},
  //   {'name': 'Pasta', 'location': {'aisle': 6, 'shelf': 2}, 'category': 'Grains', 'icon': Icons.food_bank, 'position': const Offset(6, 2)},
  //   {'name': 'Flour', 'location': {'aisle': 6, 'shelf': 3}, 'category': 'Grains', 'icon': Icons.food_bank, 'position': const Offset(6, 3)},
  //   {'name': 'Sugar', 'location': {'aisle': 7, 'shelf': 1}, 'category': 'Baking', 'icon': Icons.star, 'position': const Offset(7, 1)},
  //   {'name': 'Salt', 'location': {'aisle': 7, 'shelf': 2}, 'category': 'Baking', 'icon': Icons.food_bank, 'position': const Offset(7, 2)},
  //   {'name': 'Baking Powder', 'location': {'aisle': 7, 'shelf': 3}, 'category': 'Baking', 'icon': Icons.bakery_dining, 'position': const Offset(7, 3)},
  //   {'name': 'Eggs', 'location': {'aisle': 8, 'shelf': 1}, 'category': 'Dairy', 'icon': Icons.egg, 'position': const Offset(8, 1)},
  //   {'name': 'Yogurt', 'location': {'aisle': 8, 'shelf': 2}, 'category': 'Dairy', 'icon': Icons.local_drink, 'position': const Offset(8, 2)},
  //   {'name': 'Oatmeal', 'location': {'aisle': 9, 'shelf': 1}, 'category': 'Breakfast', 'icon': Icons.breakfast_dining, 'position': const Offset(9, 1)},
  //   {'name': 'Cereal', 'location': {'aisle': 9, 'shelf': 2}, 'category': 'Breakfast', 'icon': Icons.breakfast_dining, 'position': const Offset(9, 2)},
  //   {'name': 'Tomato Sauce', 'location': {'aisle': 10, 'shelf': 1}, 'category': 'Condiments', 'icon': Icons.soup_kitchen, 'position': const Offset(10, 1)},
  // ];
  // final List<Map<String, dynamic>> _productList = [
  //   {
  //     'name': 'Milk',
  //     'location': {'aisle': 1, 'shelf': 1},
  //     'category': 'Dairy',
  //     'icon': Icons.local_drink,
  //     'position': const Offset(1, 1),
  //     'recommended': ['Bread', 'Butter', 'Cheese']
  //   },
  //   {
  //     'name': 'Cheese',
  //     'location': {'aisle': 1, 'shelf': 2},
  //     'category': 'Dairy',
  //     'icon': Icons.restaurant,
  //     'position': const Offset(1, 2),
  //     'recommended': ['Milk', 'Wine', 'Crackers']
  //   },
  //   {
  //     'name': 'Butter',
  //     'location': {'aisle': 1, 'shelf': 3},
  //     'category': 'Dairy',
  //     'icon': Icons.food_bank,
  //     'position': const Offset(1, 3),
  //     'recommended': ['Bread', 'Eggs', 'Pancakes']
  //   },
  //   {
  //     'name': 'Bread',
  //     'location': {'aisle': 2, 'shelf': 1},
  //     'category': 'Bakery',
  //     'icon': Icons.bakery_dining,
  //     'position': const Offset(2, 1),
  //     'recommended': ['Milk', 'Butter', 'Jam']
  //   },
  //   {
  //     'name': 'Cake',
  //     'location': {'aisle': 2, 'shelf': 2},
  //     'category': 'Bakery',
  //     'icon': Icons.cake,
  //     'position': const Offset(2, 2),
  //     'recommended': ['Tea', 'Coffee', 'Juice']
  //   },
  //   {
  //     'name': 'Croissant',
  //     'location': {'aisle': 2, 'shelf': 3},
  //     'category': 'Bakery',
  //     'icon': Icons.local_cafe,
  //     'position': const Offset(2, 3),
  //     'recommended': ['Coffee', 'Butter', 'Jam']
  //   },
  //   {
  //     'name': 'Apples',
  //     'location': {'aisle': 3, 'shelf': 1},
  //     'category': 'Fruits',
  //     'icon': Icons.apple,
  //     'position': const Offset(3, 1),
  //     'recommended': ['Bananas', 'Oranges', 'Yogurt']
  //   },
  //   {
  //     'name': 'Bananas',
  //     'location': {'aisle': 3, 'shelf': 2},
  //     'category': 'Fruits',
  //     'icon': Icons.local_grocery_store,
  //     'position': const Offset(3, 2),
  //     'recommended': ['Apples', 'Oatmeal', 'Milk']
  //   },
  //   {
  //     'name': 'Oranges',
  //     'location': {'aisle': 3, 'shelf': 3},
  //     'category': 'Fruits',
  //     'icon': Icons.local_grocery_store,
  //     'position': const Offset(3, 3),
  //     'recommended': ['Apples', 'Bananas', 'Juice']
  //   },
  //   {
  //     'name': 'Chicken',
  //     'location': {'aisle': 4, 'shelf': 1},
  //     'category': 'Meat',
  //     'icon': Icons.local_dining,
  //     'position': const Offset(4, 1),
  //     'recommended': ['Beef', 'Fish', 'Rice']
  //   },
  //   {
  //     'name': 'Beef',
  //     'location': {'aisle': 4, 'shelf': 2},
  //     'category': 'Meat',
  //     'icon': Icons.local_dining,
  //     'position': const Offset(4, 2),
  //     'recommended': ['Chicken', 'Wine', 'Potatoes']
  //   },
  //   {
  //     'name': 'Fish',
  //     'location': {'aisle': 4, 'shelf': 3},
  //     'category': 'Meat',
  //     'icon': Icons.local_dining,
  //     'position': const Offset(4, 3),
  //     'recommended': ['Rice', 'Lemon', 'Wine']
  //   },
  //   {
  //     'name': 'Juice',
  //     'location': {'aisle': 5, 'shelf': 1},
  //     'category': 'Beverages',
  //     'icon': Icons.local_drink,
  //     'position': const Offset(5, 1),
  //     'recommended': ['Oranges', 'Tea', 'Cake']
  //   },
  //   {
  //     'name': 'Water',
  //     'location': {'aisle': 5, 'shelf': 2},
  //     'category': 'Beverages',
  //     'icon': Icons.local_drink,
  //     'position': const Offset(5, 2),
  //     'recommended': ['Juice', 'Tea', 'Coffee']
  //   },
  //   {
  //     'name': 'Coffee',
  //     'location': {'aisle': 5, 'shelf': 3},
  //     'category': 'Beverages',
  //     'icon': Icons.coffee,
  //     'position': const Offset(5, 3),
  //     'recommended': ['Cake', 'Croissant', 'Milk']
  //   },
  //   {
  //     'name': 'Tea',
  //     'location': {'aisle': 5, 'shelf': 4},
  //     'category': 'Beverages',
  //     'icon': Icons.local_cafe,
  //     'position': const Offset(5, 4),
  //     'recommended': ['Cake', 'Croissant', 'Water']
  //   },
  //   {
  //     'name': 'Rice',
  //     'location': {'aisle': 6, 'shelf': 1},
  //     'category': 'Grains',
  //     'icon': Icons.rice_bowl,
  //     'position': const Offset(6, 1),
  //     'recommended': ['Fish', 'Chicken', 'Pasta']
  //   },
  //   {
  //     'name': 'Pasta',
  //     'location': {'aisle': 6, 'shelf': 2},
  //     'category': 'Grains',
  //     'icon': Icons.food_bank,
  //     'position': const Offset(6, 2),
  //     'recommended': ['Cheese', 'Tomato Sauce', 'Bread']
  //   },
  //   {
  //     'name': 'Flour',
  //     'location': {'aisle': 6, 'shelf': 3},
  //     'category': 'Grains',
  //     'icon': Icons.food_bank,
  //     'position': const Offset(6, 3),
  //     'recommended': ['Sugar', 'Butter', 'Eggs']
  //   },
  //   {
  //     'name': 'Sugar',
  //     'location': {'aisle': 7, 'shelf': 1},
  //     'category': 'Baking',
  //     'icon': Icons.star,
  //     'position': const Offset(7, 1),
  //     'recommended': ['Flour', 'Butter', 'Baking Powder']
  //   },
  //   {
  //     'name': 'Salt',
  //     'location': {'aisle': 7, 'shelf': 2},
  //     'category': 'Baking',
  //     'icon': Icons.food_bank,
  //     'position': const Offset(7, 2),
  //     'recommended': ['Pasta', 'Tomato Sauce', 'Chicken']
  //   },
  //   {
  //     'name': 'Baking Powder',
  //     'location': {'aisle': 7, 'shelf': 3},
  //     'category': 'Baking',
  //     'icon': Icons.bakery_dining,
  //     'position': const Offset(7, 3),
  //     'recommended': ['Flour', 'Butter', 'Eggs']
  //   },
  //   {
  //     'name': 'Eggs',
  //     'location': {'aisle': 8, 'shelf': 1},
  //     'category': 'Dairy',
  //     'icon': Icons.egg,
  //     'position': const Offset(8, 1),
  //     'recommended': ['Bacon', 'Bread', 'Butter']
  //   },
  //   {
  //     'name': 'Yogurt',
  //     'location': {'aisle': 8, 'shelf': 2},
  //     'category': 'Dairy',
  //     'icon': Icons.local_drink,
  //     'position': const Offset(8, 2),
  //     'recommended': ['Apples', 'Bananas', 'Granola']
  //   },
  //   {
  //     'name': 'Oatmeal',
  //     'location': {'aisle': 9, 'shelf': 1},
  //     'category': 'Breakfast',
  //     'icon': Icons.breakfast_dining,
  //     'position': const Offset(9, 1),
  //     'recommended': ['Bananas', 'Milk', 'Honey']
  //   },
  //   {
  //     'name': 'Cereal',
  //     'location': {'aisle': 9, 'shelf': 2},
  //     'category': 'Breakfast',
  //     'icon': Icons.breakfast_dining,
  //     'position': const Offset(9, 2),
  //     'recommended': ['Milk', 'Bananas', 'Yogurt']
  //   },
  //   {
  //     'name': 'Tomato Sauce',
  //     'location': {'aisle': 10, 'shelf': 1},
  //     'category': 'Condiments',
  //     'icon': Icons.soup_kitchen,
  //     'position': const Offset(10, 1),
  //     'recommended': ['Pasta', 'Cheese', 'Garlic']
  //   },
  // ];
  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Milk',
      'location': {'aisle': 1, 'shelf': 1},
      'category': 'Dairy',
      'icon': Icons.local_drink,
      'position': const Offset(1, 1),
      'recommendedItems': [
        {'name': 'Cookies', 'icon': Icons.cookie},
        {'name': 'Cereal', 'icon': Icons.breakfast_dining},
        {'name': 'Juice', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Cheese',
      'location': {'aisle': 1, 'shelf': 2},
      'category': 'Dairy',
      'icon': Icons.restaurant,
      'position': const Offset(1, 2),
      'recommendedItems': [
        {'name': 'Crackers', 'icon': Icons.bakery_dining},
        {'name': 'Wine', 'icon': Icons.wine_bar},
        {'name': 'Bread', 'icon': Icons.bakery_dining},
      ],
    },
    {
      'name': 'Butter',
      'location': {'aisle': 1, 'shelf': 3},
      'category': 'Dairy',
      'icon': Icons.food_bank,
      'position': const Offset(1, 3),
      'recommendedItems': [
        {'name': 'Bread', 'icon': Icons.bakery_dining},
        {'name': 'Jam', 'icon': Icons.air},
        {'name': 'Pancakes', 'icon': Icons.cake},
      ],
    },
    {
      'name': 'Bread',
      'location': {'aisle': 2, 'shelf': 1},
      'category': 'Bakery',
      'icon': Icons.bakery_dining,
      'position': const Offset(2, 1),
      'recommendedItems': [
        {'name': 'Butter', 'icon': Icons.food_bank},
        {'name': 'Jam', 'icon': Icons.air},
        {'name': 'Milk', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Cake',
      'location': {'aisle': 2, 'shelf': 2},
      'category': 'Bakery',
      'icon': Icons.cake,
      'position': const Offset(2, 2),
      'recommendedItems': [
        {'name': 'Tea', 'icon': Icons.local_cafe},
        {'name': 'Ice Cream', 'icon': Icons.icecream},
        {'name': 'Cookies', 'icon': Icons.cookie},
      ],
    },
    {
      'name': 'Croissant',
      'location': {'aisle': 2, 'shelf': 3},
      'category': 'Bakery',
      'icon': Icons.local_cafe,
      'position': const Offset(2, 3),
      'recommendedItems': [
        {'name': 'Coffee', 'icon': Icons.coffee},
        {'name': 'Butter', 'icon': Icons.food_bank},
        {'name': 'Chocolate', 'icon': Icons.food_bank_outlined},
      ],
    },
    {
      'name': 'Apples',
      'location': {'aisle': 3, 'shelf': 1},
      'category': 'Fruits',
      'icon': Icons.apple,
      'position': const Offset(3, 1),
      'recommendedItems': [
        {'name': 'Bananas', 'icon': Icons.local_grocery_store},
        {'name': 'Peanut Butter', 'icon': Icons.food_bank},
        {'name': 'Yogurt', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Bananas',
      'location': {'aisle': 3, 'shelf': 2},
      'category': 'Fruits',
      'icon': Icons.local_grocery_store,
      'position': const Offset(3, 2),
      'recommendedItems': [
        {'name': 'Peanut Butter', 'icon': Icons.food_bank},
        {'name': 'Milk', 'icon': Icons.local_drink},
        {'name': 'Cereal', 'icon': Icons.breakfast_dining},
      ],
    },
    {
      'name': 'Oranges',
      'location': {'aisle': 3, 'shelf': 3},
      'category': 'Fruits',
      'icon': Icons.local_grocery_store,
      'position': const Offset(3, 3),
      'recommendedItems': [
        {'name': 'Juice', 'icon': Icons.local_drink},
        {'name': 'Grapes', 'icon': Icons.local_grocery_store},
        {'name': 'Bananas', 'icon': Icons.local_grocery_store},
      ],
    },
    {
      'name': 'Chicken',
      'location': {'aisle': 4, 'shelf': 1},
      'category': 'Meat',
      'icon': Icons.local_dining,
      'position': const Offset(4, 1),
      'recommendedItems': [
        {'name': 'Spices', 'icon': Icons.soup_kitchen},
        {'name': 'Rice', 'icon': Icons.rice_bowl},
        {'name': 'Vegetables', 'icon': Icons.soup_kitchen},
      ],
    },
    {
      'name': 'Beef',
      'location': {'aisle': 4, 'shelf': 2},
      'category': 'Meat',
      'icon': Icons.local_dining,
      'position': const Offset(4, 2),
      'recommendedItems': [
        {'name': 'Wine', 'icon': Icons.wine_bar},
        {'name': 'Garlic', 'icon': Icons.local_florist},
        {'name': 'Bread', 'icon': Icons.bakery_dining},
      ],
    },
    {
      'name': 'Fish',
      'location': {'aisle': 4, 'shelf': 3},
      'category': 'Meat',
      'icon': Icons.local_dining,
      'position': const Offset(4, 3),
      'recommendedItems': [
        {'name': 'Lemon', 'icon': Icons.soup_kitchen},
        {'name': 'Garlic', 'icon': Icons.local_florist},
        {'name': 'Herbs', 'icon': Icons.grass},
      ],
    },
    {
      'name': 'Juice',
      'location': {'aisle': 5, 'shelf': 1},
      'category': 'Beverages',
      'icon': Icons.local_drink,
      'position': const Offset(5, 1),
      'recommendedItems': [
        {'name': 'Sandwich', 'icon': Icons.fastfood},
        {'name': 'Cookies', 'icon': Icons.cookie},
        {'name': 'Water', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Water',
      'location': {'aisle': 5, 'shelf': 2},
      'category': 'Beverages',
      'icon': Icons.local_drink,
      'position': const Offset(5, 2),
      'recommendedItems': [
        {'name': 'Lemon', 'icon': Icons.soup_kitchen},
        {'name': 'Ice', 'icon': Icons.ac_unit},
        {'name': 'Tea', 'icon': Icons.local_cafe},
      ],
    },
    {
      'name': 'Coffee',
      'location': {'aisle': 5, 'shelf': 3},
      'category': 'Beverages',
      'icon': Icons.coffee,
      'position': const Offset(5, 3),
      'recommendedItems': [
        {'name': 'Milk', 'icon': Icons.local_drink},
        {'name': 'Sugar', 'icon': Icons.star},
        {'name': 'Croissant', 'icon': Icons.local_cafe},
      ],
    },
    {
      'name': 'Tea',
      'location': {'aisle': 5, 'shelf': 4},
      'category': 'Beverages',
      'icon': Icons.local_cafe,
      'position': const Offset(5, 4),
      'recommendedItems': [
        {'name': 'Honey', 'icon': Icons.hive},
        {'name': 'Cookies', 'icon': Icons.cookie},
        {'name': 'Lemon', 'icon': Icons.soup_kitchen},
      ],
    },
    {
      'name': 'Rice',
      'location': {'aisle': 6, 'shelf': 1},
      'category': 'Grains',
      'icon': Icons.rice_bowl,
      'position': const Offset(6, 1),
      'recommendedItems': [
        {'name': 'Spices', 'icon': Icons.soup_kitchen},
        {'name': 'Chicken', 'icon': Icons.local_dining},
        {'name': 'Vegetables', 'icon': Icons.soup_kitchen},
      ],
    },
    {
      'name': 'Pasta',
      'location': {'aisle': 6, 'shelf': 2},
      'category': 'Grains',
      'icon': Icons.food_bank,
      'position': const Offset(6, 2),
      'recommendedItems': [
        {'name': 'Tomato Sauce', 'icon': Icons.soup_kitchen},
        {'name': 'Cheese', 'icon': Icons.restaurant},
        {'name': 'Bread', 'icon': Icons.bakery_dining},
      ],
    },
    {
      'name': 'Flour',
      'location': {'aisle': 6, 'shelf': 3},
      'category': 'Grains',
      'icon': Icons.food_bank,
      'position': const Offset(6, 3),
      'recommendedItems': [
        {'name': 'Sugar', 'icon': Icons.star},
        {'name': 'Butter', 'icon': Icons.food_bank},
        {'name': 'Eggs', 'icon': Icons.egg},
      ],
    },
    {
      'name': 'Sugar',
      'location': {'aisle': 7, 'shelf': 1},
      'category': 'Baking',
      'icon': Icons.star,
      'position': const Offset(7, 1),
      'recommendedItems': [
        {'name': 'Flour', 'icon': Icons.food_bank},
        {'name': 'Butter', 'icon': Icons.food_bank},
        {'name': 'Cinnamon', 'icon': Icons.soup_kitchen},
      ],
    },
    {
      'name': 'Salt',
      'location': {'aisle': 7, 'shelf': 2},
      'category': 'Baking',
      'icon': Icons.food_bank,
      'position': const Offset(7, 2),
      'recommendedItems': [
        {'name': 'Pepper', 'icon': Icons.soup_kitchen},
        {'name': 'Garlic', 'icon': Icons.local_florist},
        {'name': 'Olive Oil', 'icon': Icons.kitchen},
      ],
    },
    {
      'name': 'Baking Powder',
      'location': {'aisle': 7, 'shelf': 3},
      'category': 'Baking',
      'icon': Icons.bakery_dining,
      'position': const Offset(7, 3),
      'recommendedItems': [
        {'name': 'Flour', 'icon': Icons.food_bank},
        {'name': 'Sugar', 'icon': Icons.star},
        {'name': 'Vanilla Extract', 'icon': Icons.local_florist},
      ],
    },
    {
      'name': 'Eggs',
      'location': {'aisle': 8, 'shelf': 1},
      'category': 'Dairy',
      'icon': Icons.egg,
      'position': const Offset(8, 1),
      'recommendedItems': [
        {'name': 'Bacon', 'icon': Icons.local_dining},
        {'name': 'Cheese', 'icon': Icons.restaurant},
        {'name': 'Milk', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Yogurt',
      'location': {'aisle': 8, 'shelf': 2},
      'category': 'Dairy',
      'icon': Icons.local_drink,
      'position': const Offset(8, 2),
      'recommendedItems': [
        {'name': 'Granola', 'icon': Icons.bakery_dining},
        {'name': 'Honey', 'icon': Icons.hive},
        {'name': 'Berries', 'icon': Icons.local_grocery_store},
      ],
    },
    {
      'name': 'Oatmeal',
      'location': {'aisle': 9, 'shelf': 1},
      'category': 'Breakfast',
      'icon': Icons.breakfast_dining,
      'position': const Offset(9, 1),
      'recommendedItems': [
        {'name': 'Milk', 'icon': Icons.local_drink},
        {'name': 'Honey', 'icon': Icons.hive},
        {'name': 'Bananas', 'icon': Icons.local_grocery_store},
      ],
    },
    {
      'name': 'Cereal',
      'location': {'aisle': 9, 'shelf': 2},
      'category': 'Breakfast',
      'icon': Icons.breakfast_dining,
      'position': const Offset(9, 2),
      'recommendedItems': [
        {'name': 'Milk', 'icon': Icons.local_drink},
        {'name': 'Bananas', 'icon': Icons.local_grocery_store},
        {'name': 'Juice', 'icon': Icons.local_drink},
      ],
    },
    {
      'name': 'Tomato Sauce',
      'location': {'aisle': 10, 'shelf': 1},
      'category': 'Condiments',
      'icon': Icons.soup_kitchen,
      'position': const Offset(10, 1),
      'recommendedItems': [
        {'name': 'Pasta', 'icon': Icons.food_bank},
        {'name': 'Cheese', 'icon': Icons.restaurant},
        {'name': 'Garlic', 'icon': Icons.local_florist},
      ],
    },
  ];



  // Initialize shopping list with quantities set to 0
  List<Map<String, dynamic>> _shoppingList = [];

  // This will track the quantities of each item selected
  final Map<String, int> _itemQuantities = {};

  List<Map<String, dynamic>> _filteredProductList = [];
  bool _showGreeting = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadShoppingList();
    _speakGreeting();
    _hideGreeting();
    _filteredProductList = _productList;

    // Initialize quantities for all products
    for (var product in _productList) {
      _itemQuantities[product['name']] = 0;
    }
  }

  void _speakGreeting() async {
    await flutterTts.speak("Welcome! Let's start shopping.");
  }

  void _hideGreeting() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _showGreeting = false;
    });
  }

  void _loadShoppingList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList('shopping_list');
    if (savedList != null) {
      setState(() {
        _shoppingList = savedList.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
        _updateQuantitiesFromShoppingList();
      });
    }
  }

  void _updateQuantitiesFromShoppingList() {
    for (var item in _shoppingList) {
      _itemQuantities[item['name']] = item['quantity'];
    }
  }

  void _saveShoppingList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = _shoppingList.map((item) => jsonEncode(item)).toList();
    prefs.setStringList('shopping_list', savedList);
  }

  void _updateItemQuantity(Map<String, dynamic> item, int change) {
    setState(() {
      final currentQuantity = _itemQuantities[item['name']] ?? 0;
      final newQuantity = currentQuantity + change;

      if (newQuantity >= 0) {
        _itemQuantities[item['name']] = newQuantity;
        _shoppingList.removeWhere((element) => element['name'] == item['name']);
        if (newQuantity > 0) {
          _shoppingList.add({...item, 'quantity': newQuantity});
        }
        _saveShoppingList();
      }
    });
  }

  void _findShortestPath() {
    const entrance = Offset(0.5, 0.9); // Adjusted entrance position
    const exit = Offset(0.5, 0.1);     // Adjusted exit position

    final nodes = _shoppingList.map((item) {
      return Node(position: item['position'], name: item['name']);
    }).toList();

    final AStar aStar = AStar();
    final List<Node> path = aStar.findShortestPath(entrance, exit, nodes);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapView(path, _productList),
      ),
    );
  }


  void _filterProducts(String query) {
    setState(() {
      _filteredProductList = _productList
          .where((product) => product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showAvailableItems() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: TextField(
                  onChanged: (query) => _filterProducts(query),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredProductList.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProductList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: ListTile(
                        leading: Icon(product['icon'], color: Colors.blue),
                        title: Text(product['name']),
                        subtitle: Text('Aisle: ${product['location']['aisle']}, Shelf: ${product['location']['shelf']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () => _updateItemQuantity(product, -1),
                            ),
                            Text('${_itemQuantities[product['name']]}'),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () => _updateItemQuantity(product, 1),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPEEDSHOP'),
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bghome.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: _shoppingList.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied,
                    size: 100,
                    color: Colors.grey[600],
                  ),
                  Text(
                    'Your Cart is Empty',
                    style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 100,
                    color: Colors.green[600],
                  ),
                  Text(
                    'Your Cart',
                    style: TextStyle(fontSize: 24, color: Colors.green[600]),
                  ),
                ],
              ),
            ),
            if (_showGreeting)
              Center(
                child: Container(
                  color: Colors.green[600],
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Happy Shopping!',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _showAvailableItems,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  ),
                  child: const Text(
                    'Add Items',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage(_shoppingList, _findShortestPath, productList: _productList)),
                        );
                      },
                      backgroundColor: Colors.orangeAccent,
                      child: const Icon(Icons.shopping_cart),
                    ),
                    if (_shoppingList.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '${_shoppingList.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
