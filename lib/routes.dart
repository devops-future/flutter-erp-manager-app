import 'package:flutter/material.dart';
import 'package:ancalmo_manager/screens/home/category.dart';
import 'package:ancalmo_manager/screens/orders/list.dart';
import 'package:ancalmo_manager/screens/orders/detail.dart';
import 'package:ancalmo_manager/screens/login/login_screen.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context) => new CategoryPage(),
  '/list': (BuildContext context) => new ListPage(context),
  '/detail': (BuildContext context) => new DetailPage(context),
  '/': (BuildContext context) => new LoginScreen(),
};
