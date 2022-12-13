import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:order_food/model/cemilan_model.dart';
import 'package:order_food/providers/provider.dart';
import 'package:provider/provider.dart';

import '../providers/get_data.dart';

Widget cemilanTab(BuildContext context) {
  return RefreshIndicator(
    onRefresh: GetData.getRefresh,
    child: SafeArea(
        child: FutureBuilder(
      future: GetData.getCemilan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.only(bottom: 60),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  CemilanModel cemil = snapshot.data![index];
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
                                      image: NetworkImage("${cemil.image}"))),
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
                                          '${cemil.name}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          '${cemil.description}',
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
                                        'Rp. ${cemil.price}',
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
                                                  .addCemilan(
                                                      cemil.name!,
                                                      cemil.id!,
                                                      false,
                                                      cemil.price!);
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
                                            var id = value.cemil.indexWhere(
                                                (element) =>
                                                    element.menuId ==
                                                    snapshot.data![index].id);
                                            return Text(
                                              (id == -1)
                                                  ? "0"
                                                  : value.cemil[id].qty
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
                                                  .addCemilan(
                                                      cemil.name!,
                                                      cemil.id!,
                                                      true,
                                                      cemil.price!);
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
