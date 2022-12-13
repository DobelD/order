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
      appBar: AppBar(
        elevation: 1,
        actions: [
          Row(
            children: [
              SizedBox(
                child: DropdownButton<BluetoothDevice>(
                    underline: SizedBox(),
                    value: selectedDevice,
                    hint: Text("Select printer "),
                    iconEnabledColor: Colors.black,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    items: device
                        .map((e) => DropdownMenuItem(
                              child: Text(e.name!),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (device) {
                      setState(() {
                        selectedDevice = device;
                      });
                    }),
              ),
              SizedBox(
                child: IconButton(
                  onPressed: () async {
                    await printer.connect(selectedDevice!);
                    if (selectedDevice!.connected) {
                      await ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Berhasil conect')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal conect')));
                    }
                  },
                  icon: Icon(
                    Icons.print_rounded,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Consumer<CartProvider>(builder: (context, value, _) {
              String namaMenu = "";
              String qtyMenu = "";
              String hargaMenu = "";
              String tothar = "";
              for (var element in value.cart) {
                namaMenu = "$namaMenu\n${element.name}\n";
                qtyMenu = "$qtyMenu\n${element.qty}\n";
                hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                tothar = "$tothar ${element.price * element.qty}";
              }
              for (var element in value.minum) {
                namaMenu = "$namaMenu\n${element.name}\n";
                qtyMenu = "$qtyMenu\n${element.qty}\n";
                hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                tothar = "$tothar ${element.price * element.qty}";
              }
              for (var element in value.cemil) {
                namaMenu = "$namaMenu\n${element.name}\n";
                qtyMenu = "$qtyMenu\n${element.qty}\n";
                hargaMenu = "$hargaMenu\n Rp. ${element.price}\n";
                tothar = "$tothar ${element.price * element.qty}";
              }
              return Column(
                children: [
                  head(),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                    height: 25,
                  ),
                  listPesanan(
                      context, namaMenu, qtyMenu, hargaMenu, printer, tothar),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1.5,
                    height: 35,
                  ),
                  totalPesan(hargaMenu, cart, tothar),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       print(tothar);
                  //     },
                  //     child: Text("data"))
                ],
              );
            }),
          ],
        ),
      ),
      bottomSheet: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              printer.printNewLine();
            },
            child: Text('Cetak Struk'),
          )),
    );
  }
}

Widget listPesanan(BuildContext context, String namaMenu, String qtyMenu,
    String hargaMenu, BlueThermalPrinter printer, String tothar) {
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
            flex: 3,
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
        flex: 3,
        child: Text(
          "Harga",
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

Widget totalPesan(String hargaMenu, CartProvider cart, String tothar) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Total",
        style:
            GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      Text(
        "${tothar}",
        style:
            GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
