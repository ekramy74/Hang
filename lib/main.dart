import 'package:clothes/provider/admin_mode.dart';
import 'package:clothes/provider/modal_progress.dart';
import 'package:clothes/screens/adminScreens/Edit_Products.dart';
import 'package:clothes/screens/adminScreens/Manage_product.dart';
import 'package:clothes/screens/adminScreens/add_product.dart';
import 'package:clothes/screens/adminScreens/adminHome.dart';
import 'package:clothes/screens/adminScreens/order_details.dart';
import 'package:clothes/screens/adminScreens/orders_Screen.dart';
import 'package:clothes/screens/cartScreen.dart';
import 'package:clothes/screens/cartitem.dart';
import 'package:clothes/screens/drawer_screen.dart';
import 'package:clothes/screens/home_page.dart';
import 'package:clothes/screens/home_pageV2.dart';
import 'package:clothes/screens/product_info.dart';
import 'package:clothes/screens/sign_screen.dart';
import 'package:clothes/screens/start_Screen.dart';
import 'package:flutter/material.dart';
import 'package:clothes/screens/logscreen.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'screens/welcome_screen.dart';
import 'screens/choosing_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (context) => ModalHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: StartScreen.id,
        routes: {
          DrawerScreen.id: (context) => DrawerScreen(),
          HomePageV2.id: (context) => HomePageV2(),
          CartScreen.id: (context) => CartScreen(),
          Loginscreen.id: (context) => Loginscreen(),
          Signupscreen.id: (context) => Signupscreen(),
          AdminHome.id: (context) => AdminHome(),
          Addproduct.id: (context) => Addproduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          StartScreen.id: (context) => StartScreen(),
          HomePage.id: (context) => HomePage(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ChoosingScreen.id: (context) => ChoosingScreen(),
          ProductInfo.id: (context) => ProductInfo(),
          OrdersScreen.id: (context) => OrdersScreen(),
          OrderDetails.id: (context) => OrderDetails(),
        },
      ),
    );
  }
}
