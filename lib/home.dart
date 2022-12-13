import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/pages/cemilan.dart';
import 'package:order_food/pages/makanan.dart';
import 'package:order_food/pages/minum.dart';
import 'package:order_food/providers/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namaC = TextEditingController();
  TextEditingController mejaC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CartProvider cart = CartProvider();

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          // () => CartDialog.openDialog(context, namaC, mejaC)
          onPressed: () {
            Navigator.of(context).pushNamed("/cart", arguments: cart);
          },
          child: Badge(
            badgeContent: Consumer<CartProvider>(builder: (context, value, _) {
              return Text(
                (value.total > 0) ? value.total.toString() : "",
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 12),
              );
            }),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Daftar Menu",
            style: GoogleFonts.montserrat(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            tabs: [
              Text(
                "Makanan",
              ),
              Text("Minuman"),
              Text('Cemilan')
            ],
            labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black38,
            labelPadding: EdgeInsets.only(bottom: 10),
          ),
        ),
        body: TabBarView(children: [
          makanTab(context),
          minumTab(context),
          cemilanTab(context)
        ]),
      ),
    );
  }
}
