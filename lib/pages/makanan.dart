import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/providers/get_data.dart';
import 'package:order_food/model/menu_model.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

Widget makanTab(BuildContext context) {
  return RefreshIndicator(
    onRefresh: GetData.getRefresh,
    child: SafeArea(
        child: FutureBuilder(
      future: GetData.getMakanan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.only(bottom: 60),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  MenuModel menu = snapshot.data![index];
                  return Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${menu.image}"))),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Flexible(
                            flex: 8,
                            child: SizedBox(
                              height: 85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${menu.name}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          '${menu.description}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp. ${menu.price}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                            width: 90,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .addMakanan(
                                                              menu.name!,
                                                              menu.id!,
                                                              false,
                                                              menu.price!,
                                                              0);
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .remove_circle_rounded,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Consumer<CartProvider>(builder:
                                                    (context, value, _) {
                                                  var id = value.cart
                                                      .indexWhere((element) =>
                                                          element.menuId ==
                                                          snapshot
                                                              .data![index].id);
                                                  return Text(
                                                    (id == -1)
                                                        ? "0"
                                                        : value.cart[id].qty
                                                            .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                  );
                                                }),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .addMakanan(
                                                              menu.name!,
                                                              menu.id!,
                                                              true,
                                                              menu.price!,
                                                              0);
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 30,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
                }
                );
          } else {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }
        }
      },
    )),
  );
}
