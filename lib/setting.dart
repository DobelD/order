import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_food/home.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Setting",
        style:
            GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double top = MediaQuery.of(context).padding.top;

    double heightDevice = height - appbar().preferredSize.height - top;
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: heightDevice * 0.17,
                width: heightDevice * 0.17,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: heightDevice * 0.1,
              width: width * 0.8,
              child: TextField(
                style: GoogleFonts.montserrat(),
                decoration: InputDecoration(
                    hintText: "Nama Kafe",
                    hintStyle: GoogleFonts.montserrat(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: heightDevice * 0.1,
              width: width * 0.8,
              child: TextField(
                style: GoogleFonts.montserrat(),
                decoration: InputDecoration(
                    hintText: "Alamat",
                    hintStyle: GoogleFonts.montserrat(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text("Pilih Printer",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            printer.connect(selectedDevice!);
                          },
                          child: Text(
                            "Connect",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            printer.disconnect();
                          },
                          child: Text(
                            "Disconnect",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if ((await printer.isConnected)!) {
                    printer.printCustom("Test Print", 0, 1);
                    printer.printQRcode("Test Print", 200, 200, 1);
                  }
                },
                child: Text("Print"),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home())),
            child: Text(
              'Simpan',
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
