import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/providers/provider.dart';
import 'package:provider/provider.dart';

class CartPrint extends StatefulWidget {
  const CartPrint({super.key});

  @override
  State<CartPrint> createState() => _CartPrintState();
}

class _CartPrintState extends State<CartPrint> {
  List<BluetoothDevice> device = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();
    getDevice();
  }

  void getDevice() async {
    device = await printer.getBondedDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = ModalRoute.of(context)!.settings.arguments as CartProvider;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Consumer<CartProvider>(builder: (context, value, _) {
                String namaMenu = "";
                String qtyMenu = "";
                String hargaMenu = "";
                int banyakMakanan = 0;
                int banyakMinum = 0;
                int banyakCemil = 0;
                int total_cart = 0;
                int total_minum = 0;
                int total_cemilan = 0;

                for (var element in value.cart) {
                  namaMenu = "$namaMenu\n${element.name}\n";
                  qtyMenu = "$qtyMenu\n${element.qty}\n";
                  banyakMakanan += element.qty;
                  hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                  total_cart += element.price * element.qty;
                }
                for (var element in value.minum) {
                  namaMenu = "$namaMenu\n${element.name}\n";
                  qtyMenu = "$qtyMenu\n${element.qty}\n";
                  banyakMinum += element.qty;
                  hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                  total_minum += element.price * element.qty;
                }
                for (var element in value.cemil) {
                  namaMenu = "$namaMenu\n${element.name}\n";
                  qtyMenu = "$qtyMenu\n${element.qty}\n";
                  banyakCemil += element.qty;
                  hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                  total_cemilan += element.price * element.qty;
                }
                int total_qty = banyakMakanan + banyakMinum + banyakCemil;
                int total_pesanan = total_cart + total_minum + total_cemilan;
                return Column(
                  children: [
                    head(),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                      height: 25,
                    ),
                    // , printer
                    listPesanan(context, namaMenu, qtyMenu, hargaMenu),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.5,
                      height: 35,
                    ),
                    totalPesan(total_qty, total_pesanan),
                    printStruk(context, namaMenu, qtyMenu, hargaMenu,
                        total_pesanan, printer)
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget printStruk(BuildContext context, String namaMenu, String qtyMenu,
    String hargaMenu, int total_pesanan, BlueThermalPrinter printer) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () async {
            if ((await printer.isConnected)!) {
              printer.printCustom("$namaMenu $qtyMenu $hargaMenu", 200, 0);
              printer.printNewLine();
            }
          },
          child: Text(
            'Bayar',
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
        )),
  );
}

// , BlueThermalPrinter printer
Widget listPesanan(
    BuildContext context, String namaMenu, String qtyMenu, String hargaMenu) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Text(
              namaMenu,
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              qtyMenu,
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              hargaMenu,
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      // ElevatedButton(
      //   onPressed: () async {
      //     if ((await printer.isConnected)!) {
      //       printer.printNewLine();
      //       printer.print3Column(namaMenu, qtyMenu, hargaMenu, 1);
      //     }
      //   },
      //   child: Text('Cetak Struk'),
      // )
    ],
  );
}

Widget head() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 8,
        child: Text(
          "Menu Item",
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          "Qty",
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        flex: 4,
        child: Text(
          "Harga",
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

Widget totalPesan(int total_qty, int total_pesanan) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 8,
        child: Text(
          "Total",
          style:
              GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
          flex: 3,
          child: Text(
            '${total_qty}',
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.w600),
          )),
      Expanded(
        flex: 4,
        child: Text(
          "Rp. ${total_pesanan}",
          style:
              GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
