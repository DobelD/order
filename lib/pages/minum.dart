import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:order_food/providers/get_data.dart';
import 'package:order_food/model/minuman_model.dart';
import 'package:order_food/providers/provider.dart';
import 'package:provider/provider.dart';

Widget minumTab(BuildContext context) {
  return RefreshIndicator(
    onRefresh: GetData.getRefresh,
    child: SafeArea(
        child: FutureBuilder(
      future: GetData.getMinuman(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.only(bottom: 60),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  MinumModel menu = snapshot.data![index];
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
                                  Row(
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
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .addMinuman(
                                                      menu.name!,
                                                      menu.id!,
                                                      false,
                                                      menu.price!);
                                            },
                                            child: const Icon(
                                              Icons.remove_circle_rounded,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Consumer<CartProvider>(
                                              builder: (context, value, _) {
                                            var id = value.minum.indexWhere(
                                                (element) =>
                                                    element.menuId ==
                                                    snapshot.data![index].id);
                                            return Text(
                                              (id == -1)
                                                  ? "0"
                                                  : value.minum[id].qty
                                                      .toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            );
                                          }),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .addMinuman(
                                                      menu.name!,
                                                      menu.id!,
                                                      true,
                                                      menu.price!);
                                            },
                                            child: const Icon(
                                              Icons.add_circle_rounded,
                                              size: 30,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
                });
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
