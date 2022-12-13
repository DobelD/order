import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/providers/provider.dart';
import 'package:order_food/providers/wa.dart';
import 'package:provider/provider.dart';

class CartDialog {
  static void openDialog(BuildContext context, TextEditingController namaC,
      TextEditingController mejaC) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: GoogleFonts.montserrat(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: namaC,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Nomor Meja",
                    style: GoogleFonts.montserrat(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: mejaC,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:
                          Consumer<CartProvider>(builder: (context, value, _) {
                        String strPesanan = "";
                        for (var element in value.cart) {
                          strPesanan =
                              "$strPesanan\n${element.name} (${element.qty})";
                        }
                        for (var element in value.minum) {
                          strPesanan =
                              "$strPesanan\n${element.name} (${element.qty})";
                        }
                        for (var element in value.cemil) {
                          strPesanan =
                              "$strPesanan\n${element.name} (${element.qty})";
                        }
                        return ElevatedButton(
                            onPressed: () async {
                              String pesanan =
                                  "Nama : ${namaC.text}\nNomor Meja : ${mejaC.text}\nPesanan :\n$strPesanan";
                              await WhatsAppM.direct(pesanan);
                            },
                            child: Text(
                              "Pesan Sekarang",
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ));
                      }))
                ],
              ),
            ),
          );
        });
  }
}
