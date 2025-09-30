import 'package:flutter/material.dart';

enum Categorie {
  fruit,
  vegetables,
  meat,
  dairy,
  cards,
  sweet,
  spice,
  convenience,
  hygiene,
  other
}

class Category {
  const Category(this.title, this.color);
  final String title;
  final Color color;
}
